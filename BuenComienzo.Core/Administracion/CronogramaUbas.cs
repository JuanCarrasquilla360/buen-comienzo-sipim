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
    public class CronogramaUbas
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

        public bool InsertarCronogramaUbas(string idUbas, string idProgramacionActividades)
        {
            try
            {
                DateTime fechaCreacion = DateTime.Now;

                foreach (string idUba in idUbas.Split('|'))
                {
                    parametros = new List<Parametro>
                        {
                            new Parametro { NombreParametro = "@idProgramacionActividades", Valor = idProgramacionActividades, Tipo = typeof(string) },
                            new Parametro { NombreParametro = "@IdUba", Valor = idUba, Tipo = typeof(string) },
                        };

                    objBd.ejecutarProcedimiento("dbop_AddTBL_CRONOGRAMAUBAS", parametros);
                }

                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public DataTable ObtenerCronogramaUbas(string idProgramacionActividades)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@idProgramacionActividades", Valor = idProgramacionActividades, Tipo = typeof(string) },
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_CRONOGRAMAUBAS", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool EliminarCronogramaUbas(string idProgramacionActividades)
        {
            try
            {
                Object resp;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdProgramacionActividades", Valor = idProgramacionActividades, Tipo = typeof(string) }
                };

                resp = objBd.ejecutarProcedimiento("dbop_DeleteAllTBL_CRONOGRAMAUBAS", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }
    }
}

