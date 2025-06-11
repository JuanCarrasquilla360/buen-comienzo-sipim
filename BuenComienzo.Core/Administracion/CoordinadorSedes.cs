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
    public class CoordinadorSedes
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

        public string InsertarCoordinadorSedes(string idSedes, string idCoordinador)
        {
            try
            {
                string respuesta = "";
                DateTime fechaCreacion = DateTime.Now;

                foreach (string idSede in idSedes.Split('|'))
                {
                    parametros = new List<Parametro>
                    {
                        new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                        new Parametro { NombreParametro = "@IdSede", Valor = idSede, Tipo = typeof(string) },
                    };

                    try
                    {
                        objBd.ejecutarProcedimiento("dbop_AddTBL_COORDINADORSEDES", parametros);
                    }
                    catch (Exception e) {
                        if (e.Message.Contains("PRIMARY KEY"))
                            respuesta += "La sede " + idSede + " ya está asociada al coordinador seleccionado<br/>";
                    }
                }

                return respuesta;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return "";
            }
        }

        public bool EliminarCoordinadorSede(string idSede, string idCoordinador)
        {
            try
            {
                Object resp;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdSede", Valor = idSede, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) }
                };

                resp = objBd.ejecutarProcedimiento("dbop_DeleteTBL_COORDINADORSEDES", parametros);
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

