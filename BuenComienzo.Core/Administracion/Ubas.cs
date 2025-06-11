using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;
using BuenComienzo.Core.Administracion.To;
using System.Web.UI;

namespace BuenComienzo.Core.Administracion
{
    public class Ubas
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

        public string InsertarUba(string uba, string tipoUba, string ubaSistema, bool activo, string idUsuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@Uba", Valor = uba, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdTipoUba", Valor = tipoUba, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@UbaSistema", Valor = ubaSistema, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Activo", Valor = activo, Tipo = typeof(bool) },
                    new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaCreacion", Valor = DateTime.Now, Tipo = typeof(DateTime) }
                };

                resp = objBd.ejecutarProcedimiento("dbop_AddTBL_UBAS", parametros, "NombreUba", DbType.String, 10);

                return resp.ToString();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return "";
            }
        }


        public bool ActualizarUba(string idUba, bool activo, string idUsuarioModificacion)
        {
            try
            {
                DateTime fechaModificacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdUba", Valor = idUba, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Activo", Valor = activo, Tipo = typeof(bool) },
                    new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioModificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaModificacion", Valor = DateTime.Now, Tipo = typeof(DateTime) }
                };

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_UBAS", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        

        public DataTable ObtenerUba(string idUba)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdUba", Valor = idUba, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_UBAS", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerUbas()
        {
            try
            {
                DataTable dtDatos;

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetAllTBL_UBAS", null).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarUbasDisponibles()
        {
            try
            {
                DataTable dtDatos;

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_UBASDISPONIBLES", null).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarUbas(string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    //parametros.Add(new Parametro { NombreParametro = "@IdNitOperador", Valor = idNitOperador, Tipo = typeof(string) });
                    new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_UBAS", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarUbasCoordinador(string idCoordinador, string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_COORDINADORUBAS", parametros).Tables[0];
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

