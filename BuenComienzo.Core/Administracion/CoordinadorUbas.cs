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
    public class CoordinadorUbas
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

        public string InsertarCoordinadorUbas(string idUbas, string idCoordinador)
        {
            try
            {
                string respuesta = "";
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                foreach (string idUba in idUbas.Split('|'))
                {
                    parametros = new List<Parametro>
                    {
                        new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                        new Parametro { NombreParametro = "@IdUba", Valor = idUba, Tipo = typeof(string) },
                    };

                    try
                    {
                        objBd.ejecutarProcedimiento("dbop_AddTBL_COORDINADORUBAS", parametros);
                    }
                    catch (Exception e) {
                        if (e.Message.Contains("PRIMARY KEY"))
                            respuesta += "La uba " + idUba + " ya está asociada a un coordinador<br/>";
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

        public bool EliminarCoordinadorUba(string idUBa)
        {
            try
            {
                Object resp;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdUBa", Valor = idUBa, Tipo = typeof(string) }
                };

                resp = objBd.ejecutarProcedimiento("dbop_DeleteTBL_COORDINADORUBAS", parametros);
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

