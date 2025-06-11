using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.AccesoDatos
{
    public class AccesoDatosSQL
    {

        private SqlConnection sqlConBD;

        private SqlTransaction sqlTran;

        private bool enTransaccion;

        public bool transaccionActiva
        {
            get
            {
                return this.sqlTran != null;
            }
        }

        public AccesoDatosSQL()
        {
        }

        private bool abrirBaseDatos()
        {
            bool flag;
            try
            {
                
                if (this.sqlConBD != null && this.sqlConBD.State == ConnectionState.Open && !this.enTransaccion)
                {
                    this.cerrarBaseDatos();
                }
                if (this.sqlConBD == null || this.sqlConBD.State != ConnectionState.Open)
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["BASEDATOS"].ConnectionString;
                    this.sqlConBD = new SqlConnection(connectionString);
                    this.sqlConBD.Open();
                }
                flag = true;
            }
            catch (SqlException sqlException)
            {
                BuenComienzo.Loggin.Logger.Error("AccesoDatosSQL.abrirBaseDatos Error: " + sqlException.Message);
                throw sqlException;
            }
            return flag;
        }

        public void abrirTransaccion()
        {
            try
            {
                this.abrirBaseDatos();
                if (this.sqlConBD.State != ConnectionState.Open)
                {
                    throw new Exception("No hay una conexión de base de datos abierta");
                }
                this.sqlTran = this.sqlConBD.BeginTransaction();
                this.enTransaccion = true;
            }
            catch (SqlException sqlException)
            {
                BuenComienzo.Loggin.Logger.Error("AccesoDatosSQL.abrirTransaccion Error: " + sqlException.Message);
                this.enTransaccion = false;
                this.sqlTran = null;
                this.cerrarBaseDatos();
                throw sqlException;
            }
        }

        public void aceptarTransaccion()
        {
            try
            {
                if (this.sqlConBD.State != ConnectionState.Open)
                {
                    throw new Exception("No hay una conexión de base de datos abierta");
                }
                if (this.sqlTran == null)
                {
                    this.cerrarBaseDatos();
                    throw new Exception("No hay una ninguna transacción abierta");
                }
                this.enTransaccion = false;
                try
                {
                    this.sqlTran.Commit();
                    this.cerrarBaseDatos();
                }
                catch (SqlException sqlException)
                {
                    BuenComienzo.Loggin.Logger.Error("AccesoDatosSQL.aceptarTransaccion Error: " + sqlException.Message);
                    this.sqlTran.Rollback();
                    this.sqlTran = null;
                    this.cerrarBaseDatos();
                }
            }
            catch (SqlException sqlException1)
            {
                BuenComienzo.Loggin.Logger.Error("AccesoDatosSQL.aceptarTransaccion Error: " + sqlException1.Message);
                this.enTransaccion = false;
                this.sqlTran = null;
                this.cerrarBaseDatos();
                throw sqlException1;
            }
        }

        private bool cerrarBaseDatos()
        {
            bool flag;
            try
            {
                if (this.sqlConBD.State == ConnectionState.Open && !this.enTransaccion)
                {
                    this.sqlConBD.Close();
                }
                flag = true;
            }
            catch (SqlException sqlException)
            {
                BuenComienzo.Loggin.Logger.Error("AccesoDatosSQL.cerrarBaseDatos Error: " + sqlException.Message);
                throw sqlException;
            }
            return flag;
        }

        public void devolerTransaccion()
        {
            try
            {
                if (this.sqlConBD.State != ConnectionState.Open)
                {
                    throw new Exception("No hay una conexión de base de datos abierta");
                }
                if (this.sqlTran == null)
                {
                    this.cerrarBaseDatos();
                    throw new Exception("No hay una ninguna transacción abierta");
                }
                this.enTransaccion = false;
                this.sqlTran.Rollback();
                this.sqlTran = null;
                this.cerrarBaseDatos();
            }
            catch (SqlException sqlException)
            {
                 BuenComienzo.Loggin.Logger.Error("AccesoDatosSQL.aceptarTransaccion Error: " + sqlException.Message);
                this.enTransaccion = false;
                this.sqlTran = null;
                this.cerrarBaseDatos();
                throw sqlException;
            }
        }

        public int ejecutarProcedimiento(string procedimiento, List<Parametro> parametros)
        {
            int num;
            try
            {
                int num1 = -1;
                this.abrirBaseDatos();
                if (this.sqlConBD.State == ConnectionState.Open)
                {
                    SqlCommand sqlCommand = new SqlCommand(procedimiento, this.sqlConBD)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    if (this.transaccionActiva)
                    {
                        sqlCommand.Transaction = this.sqlTran;
                    }
                    if (parametros != null && parametros.Count > 0)
                    {
                        sqlCommand.Parameters.AddRange(this.mapearParametros(parametros));
                    }
                    num1 = sqlCommand.ExecuteNonQuery();
                }
                this.cerrarBaseDatos();
                num = num1;
            }
            catch (SqlException sqlException)
            {
                BuenComienzo.Loggin.Logger.Error("AccesoDatosSQL.ejecutarProcedimiento Error: " + sqlException.Message);
                this.cerrarBaseDatos();
                throw sqlException;
            }
            return num;
        }

        public object ejecutarProcedimiento(string procedimiento, List<Parametro> parametros, string codigoSalida, DbType tipoSalida, int tamano)
        {
            object value;
            try
            {
                int num = -1;
                this.abrirBaseDatos();
                if (this.sqlConBD.State != ConnectionState.Open)
                {
                    this.cerrarBaseDatos();
                    value = num;
                }
                else
                {
                    SqlCommand sqlCommand = new SqlCommand(procedimiento, this.sqlConBD)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    if (this.transaccionActiva)
                    {
                        sqlCommand.Transaction = this.sqlTran;
                    }
                    if (parametros != null && parametros.Count > 0)
                    {
                        sqlCommand.Parameters.AddRange(this.mapearParametros(parametros));
                    }
                    sqlCommand.Parameters.Add(new SqlParameter()
                    {
                        ParameterName = string.Concat("@", codigoSalida.ToString()),
                        DbType = tipoSalida,
                        Direction = ParameterDirection.Output,
                        Size = tamano
                    });
                    num = sqlCommand.ExecuteNonQuery();
                    value = sqlCommand.Parameters[string.Concat("@", codigoSalida)].Value;
                    this.cerrarBaseDatos();
                }
            }
            catch (SqlException sqlException)
            {
                BuenComienzo.Loggin.Logger.Error("AccesoDatosSQL.ejecutarProcedimiento Error: " + sqlException.Message);
                this.cerrarBaseDatos();
                throw sqlException;
            }
            return value;
        }

        public DataSet ejecutarProcedimientoDS(string procedimiento, List<Parametro> parametros)
        {
            DataSet dataSet;
            try
            {
                DataSet dataSet1 = new DataSet();
                this.abrirBaseDatos();
                if (this.sqlConBD.State == ConnectionState.Open)
                {
                    SqlCommand sqlCommand = new SqlCommand(procedimiento, this.sqlConBD)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    if (this.transaccionActiva)
                    {
                        sqlCommand.Transaction = this.sqlTran;
                    }
                    if (parametros != null && parametros.Count > 0)
                    {
                        sqlCommand.Parameters.AddRange(this.mapearParametros(parametros));
                    }
                    (new SqlDataAdapter(sqlCommand)).Fill(dataSet1);
                }
                this.cerrarBaseDatos();
                dataSet = dataSet1;
            }
            catch (SqlException sqlException)
            {
                BuenComienzo.Loggin.Logger.Error("AccesoDatosSQL.ejecutarProcedimientoDS Error: " + sqlException.Message);
                this.cerrarBaseDatos();
                throw sqlException;
            }
            return dataSet;
        }

        public List<object> OutputValues { get; set; }

        public bool ejecutarProcedimientoIUD(string procedimiento, List<Parametro> parametros,ref int OUT_intError, ref string OUT_strError,string ScopeIdentityName, ref int ScopeIdentityValue)
        {

            bool result = false;
            try
            {
                DataSet dataSet1 = new DataSet();
                this.abrirBaseDatos();
                if (this.sqlConBD.State == ConnectionState.Open)
                {
                    SqlCommand sqlCommand = new SqlCommand(procedimiento, this.sqlConBD)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    if (this.transaccionActiva)
                    {
                        sqlCommand.Transaction = this.sqlTran;
                    }
                    if (parametros != null && parametros.Count > 0)
                    {
                        sqlCommand.Parameters.AddRange(this.mapearParametros(parametros));
                    }

                    sqlCommand.ExecuteNonQuery();

                    OutputValues = new List<object>();
                    for (int i = 0; i < sqlCommand.Parameters.Count; i++)
                    {
                        if (sqlCommand.Parameters[i].Direction == ParameterDirection.Output)
                        {
                            OutputValues.Add(sqlCommand.Parameters[i]);
                        }
                    }

                    for (int i = 0; i < OutputValues.Count; i++)
                    {
                        SqlParameter p = (SqlParameter)OutputValues[i];

                        if (p.ParameterName == "@OUT_intError")
                        {
                            OUT_intError = (int)p.Value;
                        }
                        if (p.ParameterName == "@OUT_strError") {
                            OUT_strError = (string)p.Value;
                        }
                        if (p.ParameterName == ScopeIdentityName) {
                            ScopeIdentityValue = (int)p.Value;
                        }
                    }

                    if (OutputValues != null)
                    {
                        OutputValues = new List<object>();
                    }
                    if (OUT_intError != 0)
                    {
                        //TODO log
                        result = false;
                        //throw new Exception("Código de Error:" + OUT_intError.ToString() + Environment.NewLine + " Mensaje de Error: " + OUT_strError);
                    }
                    else {
                        result = true;
                    }

                }
                this.cerrarBaseDatos();
            }
            catch (SqlException ex)
            {
                BuenComienzo.Loggin.Logger.Error("AccesoDatosSQL.ejecutarProcedimientoIUD Error: " + ex.Message);
                result = false;
                this.cerrarBaseDatos();               
            }
            return result;
        }

        public int ejecutarSentencia(string sql)
        {
            int num;
            try
            {
                int num1 = -1;
                this.abrirBaseDatos();
                if (this.sqlConBD.State == ConnectionState.Open)
                {
                    SqlCommand sqlCommand = new SqlCommand(sql, this.sqlConBD)
                    {
                        CommandType = CommandType.Text
                    };
                    if (this.transaccionActiva)
                    {
                        sqlCommand.Transaction = this.sqlTran;
                    }
                    num1 = sqlCommand.ExecuteNonQuery();
                }
                this.cerrarBaseDatos();
                num = num1;
            }
            catch (SqlException sqlException)
            {
                BuenComienzo.Loggin.Logger.Error("AccesoDatosSQL.ejecutarSentencia Error: " + sqlException.Message);
                this.cerrarBaseDatos();
                throw sqlException;
            }
            return num;
        }

        public int ejecutarSentencia(string sql, List<Parametro> parametros)
        {
            int num;
            try
            {
                num = this.ejecutarSentencia(sql, parametros, false);
            }
            catch (SqlException sqlException)
            {
                BuenComienzo.Loggin.Logger.Error("AccesoDatosSQL.ejecutarSentencia Error: " + sqlException.Message);
                this.cerrarBaseDatos();
                throw sqlException;
            }
            return num;
        }

        public int ejecutarSentencia(string sql, List<Parametro> parametros, bool count)
        {
            int num;
            try
            {
                int num1 = -1;
                this.abrirBaseDatos();
                if (this.sqlConBD.State == ConnectionState.Open)
                {
                    SqlCommand sqlCommand = new SqlCommand(sql, this.sqlConBD)
                    {
                        CommandType = CommandType.Text
                    };
                    if (this.transaccionActiva)
                    {
                        sqlCommand.Transaction = this.sqlTran;
                    }
                    if (parametros != null && parametros.Count > 0)
                    {
                        sqlCommand.Parameters.AddRange(this.mapearParametros(parametros));
                    }
                    num1 = (!count ? sqlCommand.ExecuteNonQuery() : int.Parse(sqlCommand.ExecuteScalar().ToString()));
                }
                this.cerrarBaseDatos();
                num = num1;
            }
            catch (SqlException sqlException)
            {
                BuenComienzo.Loggin.Logger.Error("AccesoDatosSQL.ejecutarSentencia Error: " + sqlException.Message);
                this.cerrarBaseDatos();
                throw sqlException;
            }
            return num;
        }

        public DataSet ejecutarSentenciaDS(string sql)
        {
            DataSet dataSet;
            try
            {
                DataSet dataSet1 = new DataSet();
                this.abrirBaseDatos();
                if (this.sqlConBD.State == ConnectionState.Open)
                {
                    SqlCommand sqlCommand = new SqlCommand(sql, this.sqlConBD)
                    {
                        CommandType = CommandType.Text
                    };
                    if (this.transaccionActiva)
                    {
                        sqlCommand.Transaction = this.sqlTran;
                    }
                    (new SqlDataAdapter(sqlCommand)).Fill(dataSet1);
                }
                this.cerrarBaseDatos();
                dataSet = dataSet1;
            }
            catch (SqlException sqlException)
            {
                BuenComienzo.Loggin.Logger.Error("AccesoDatosSQL.ejecutarSentenciaDS Error: " + sqlException.Message);
                this.cerrarBaseDatos();
                throw sqlException;
            }
            return dataSet;
        }

        private SqlParameter[] mapearParametros(List<Parametro> parametros)
        {
            List<SqlParameter> sqlParameters = new List<SqlParameter>();
            //int i = 0;
            //try
            //{
                foreach (Parametro parametro in parametros)
                {
                    SqlParameter sqlParameter = new SqlParameter()
                    {
                        ParameterName = parametro.NombreParametro
                    };
                    if (parametro.IsOutput)
                    {
                        sqlParameter.Direction = ParameterDirection.Output;
                    }
                    if (parametro.Tipo == typeof(byte) || parametro.Tipo == typeof(byte?))
                    {
                        sqlParameter.SqlDbType = SqlDbType.TinyInt;
                        if (parametro.Valor != null)
                        {
                            sqlParameter.Value = parametro.Valor;
                        }
                        else
                        {
                            sqlParameter.Value = DBNull.Value;
                        }
                    }
                    if (parametro.Tipo == typeof(byte[]))
                    {
                        sqlParameter.SqlDbType = SqlDbType.VarBinary;
                        if (parametro.Valor != null)
                        {
                            sqlParameter.Value = parametro.Valor;
                        }
                        else
                        {
                            sqlParameter.Value = DBNull.Value;
                        }
                    }
                    if (parametro.Tipo == typeof(string))
                    {
                        sqlParameter.SqlDbType = SqlDbType.VarChar;
                        if (parametro.Valor != null)
                        {
                            sqlParameter.Value = (string)parametro.Valor;
                        }
                        else
                        {
                            sqlParameter.Value = DBNull.Value;
                        }
                    }
                    if (parametro.Tipo == typeof(short) || parametro.Tipo == typeof(short?))
                    {
                        sqlParameter.SqlDbType = SqlDbType.SmallInt;
                        if (parametro.Valor != null)
                        {
                            sqlParameter.Value = (short)parametro.Valor;
                        }
                        else
                        {
                            sqlParameter.Value = DBNull.Value;
                        }
                    }
                    if (parametro.Tipo == typeof(int) || parametro.Tipo == typeof(int) || parametro.Tipo == typeof(int?) || parametro.Tipo == typeof(int?))
                    {
                        sqlParameter.SqlDbType = SqlDbType.Int;
                        if (parametro.Valor != null)
                        {
                            sqlParameter.Value = (int)parametro.Valor;
                        }
                        else
                        {
                            sqlParameter.Value = DBNull.Value;
                        }
                    }
                    if (parametro.Tipo == typeof(long) || parametro.Tipo == typeof(long?))
                    {
                        sqlParameter.SqlDbType = SqlDbType.BigInt;
                        if (parametro.Valor != null)
                        {
                            sqlParameter.Value = (long)parametro.Valor;
                        }
                        else
                        {
                            sqlParameter.Value = DBNull.Value;
                        }
                    }
                    if (parametro.Tipo == typeof(DateTime) || parametro.Tipo == typeof(DateTime?))
                    {
                        sqlParameter.SqlDbType = SqlDbType.DateTime;
                        if (parametro.Valor != null)
                        {
                            sqlParameter.Value = (DateTime)parametro.Valor;
                        }
                        else
                        {
                            sqlParameter.Value = DBNull.Value;
                        }
                    }
                    if (parametro.Tipo == typeof(bool))
                    {
                        sqlParameter.SqlDbType = SqlDbType.Bit;
                        if (parametro.Valor != null)
                        {
                            sqlParameter.Value = (bool)parametro.Valor;
                        }
                        else
                        {
                            sqlParameter.Value = DBNull.Value;
                        }
                    }
                    if (parametro.Tipo == typeof(decimal) || parametro.Tipo == typeof(decimal?))
                    {
                        sqlParameter.SqlDbType = SqlDbType.Decimal;
                        if (parametro.Valor != null)
                        {
                            sqlParameter.Value = (decimal)parametro.Valor;
                        }
                        else
                        {
                            sqlParameter.Value = DBNull.Value;
                        }
                    }
                    if (parametro.Tipo == typeof(double) || parametro.Tipo == typeof(double?))
                    {
                        sqlParameter.SqlDbType = SqlDbType.Float;
                        if (parametro.Valor != null)
                        {
                            sqlParameter.Value = (double)parametro.Valor;
                        }
                        else
                        {
                            sqlParameter.Value = DBNull.Value;
                        }
                    }
                    if (parametro.Tipo == typeof(DataTable))
                    {
                        sqlParameter.SqlDbType = SqlDbType.Structured;
                        if (parametro.Valor != null)
                        {
                            sqlParameter.Value = (DataTable)parametro.Valor;
                        }
                        else
                        {
                            sqlParameter.Value = DBNull.Value;
                        }
                    }
                    sqlParameters.Add(sqlParameter);
                    //i++;
                }
            //}
            //catch (Exception ex)
            //{

            //    int h = 1;
            //}
            
            return sqlParameters.ToArray();
        }
    }
}
