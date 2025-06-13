using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;
using BuenComienzo.Core.Administracion.To;
using System.Web.UI;
using System.Security.Cryptography;
using System.Security.Policy;

namespace BuenComienzo.Core.Administracion
{
    public class CoordinadorAgentes
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

        public string InsertarCoordinadorAgentes(string idAgentes, string idCoordinador)
        {
            try
            {
                string respuesta = "";
                DateTime fechaCreacion = DateTime.Now;

                foreach (string idAgente in idAgentes.Split('|'))
                {
                    parametros = new List<Parametro>
                    {
                        new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                        new Parametro { NombreParametro = "@IdAgente", Valor = idAgente, Tipo = typeof(string) },
                    };

                    try
                    {
                        objBd.ejecutarProcedimiento("dbop_AddTBL_COORDINADORAGENTES", parametros);
                    }
                    catch (Exception e)
                    {
                        if (e.Message.Contains("PRIMARY KEY"))
                            respuesta += "El idAgente " + idAgentes + " ya está asociada al coordinador seleccionado<br/>";
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

        public bool EliminarCoordinadorAgentes(string idAgente, string idCoordinador)
        {
            try
            {
                Object resp;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdAgente", Valor = idAgente, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) }
                };

                resp = objBd.ejecutarProcedimiento("dbop_DeleteTBL_COORDINADORAGENTES", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public DataTable ConsultarCoordinadorAgentes(string idCoordinador)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_COORDINADORAGENTES", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarCoordinadorAgentesTransversales(string idCoordinador)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_COORDINADORAGENTEST", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarCoordinadorAgentes(string idCoordinador, string ordenar, string where, int desde, string hasta)
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

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_COORDINADORAGENTES2", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerCoordiandoresAgente(string idAgente)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdAgente", Valor = idAgente, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_COORDINADORAGENTE", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerAgentesCoordinador(string idAgente)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdAgente", Valor = idAgente, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_AGENTESCOORDINADOR", parametros).Tables[0];

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

