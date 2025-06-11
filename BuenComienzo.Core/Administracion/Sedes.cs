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
    public class Sedes
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

        public string InsertarSede(string NombreSede, string CodigoSedeSIBC, string Direccion, string Telefono,
            string Celular, string IdComuna, string IdBarrio, string Correo, string IdTenenciaInmueble, bool Activo, string idUsuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@NombreSede", Valor = NombreSede, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@CodigoSedeSIBC", Valor = CodigoSedeSIBC, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Direccion", Valor = Direccion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Telefono", Valor = Telefono, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Celular", Valor = Celular, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdComuna", Valor = IdComuna, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdBarrio", Valor = IdBarrio, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Correo", Valor = Correo, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdTenenciaInmueble", Valor = IdTenenciaInmueble, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Activo", Valor = Activo, Tipo = typeof(bool) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaCreacion", Valor = DateTime.Now, Tipo = typeof(DateTime) });

                resp = objBd.ejecutarProcedimiento("dbop_AddTBL_SEDES", parametros);

                return resp.ToString();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return "";
            }
        }


        public bool ActualizarSede(string IdSede, string NombreSede, string CodigoSedeSIBC, string Direccion, string Telefono,
            string Celular, string IdComuna, string IdBarrio, string Correo, string IdTenenciaInmueble, bool Activo, string idUsuarioModificacion)
        {
            try
            {
                DateTime fechaModificacion = DateTime.Now;

                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdSede", Valor = IdSede, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@NombreSede", Valor = NombreSede, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@CodigoSedeSIBC", Valor = CodigoSedeSIBC, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Direccion", Valor = Direccion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Telefono", Valor = Telefono, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Celular", Valor = Celular, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdComuna", Valor = IdComuna, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdBarrio", Valor = IdBarrio, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Correo", Valor = Correo, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdTenenciaInmueble", Valor = IdTenenciaInmueble, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Activo", Valor = Activo, Tipo = typeof(bool) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioModificacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaCreacion", Valor = DateTime.Now, Tipo = typeof(DateTime) });

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_SEDES", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public DataTable ObtenerSedes()
        {
            try
            {
                DataTable dtDatos;

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetAllTBL_SEDES", null).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerSedesDisponibles(string idCoordinador)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_SEDESDISPONIBLES", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerSede(string idSedes)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdSede", Valor = idSedes, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_SEDES", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarSedes(string ordenar, string where, int desde, string hasta)
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

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_SEDES", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarSedesCoordinador(string idCoordinador, string ordenar, string where, int desde, string hasta)
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

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_COORDINADORSEDES", parametros).Tables[0];
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

