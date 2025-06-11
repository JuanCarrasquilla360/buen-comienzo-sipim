using BuenComienzo.AccesoDatos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Administracion
{
    public class CargarArchivoBulk
    {
        private string strError;
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();
        public string Error
        {
            get
            {
                return strError;
            }
        }

        public DataTable ExecBulkInsert(string InputFile,string DestinationTable, string FieldDelimitator, string RowDelimitator, int MAXERRORS)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@InputFile", Valor = InputFile, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@DestinationTable", Valor = DestinationTable, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FieldDelimitator", Valor = FieldDelimitator, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@RowDelimitator", Valor = RowDelimitator, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@MAXERRORS", Valor = MAXERRORS, Tipo = typeof(int) });

                dtDatos = objBd.ejecutarProcedimientoDS("GenericBulkLoad", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

    }
}
