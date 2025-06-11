using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;

namespace BuenComienzo.Core.Administracion
{
    public class Lugares
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

        public DataTable ConsultarSedes()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("SELECT * FROM VIEW_SEDES ORDER BY NombreSede ASC").Tables[0];
            return dtDatos;
        }

        public DataTable ConsultarLugares(string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_LUGARES", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerLugar(string idLugar)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdLugar", Valor = (idLugar), Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_LUGAR", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarLugarByComuna(string IdComuna)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdComuna", Valor = IdComuna, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_Lugar_By_Comuna", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return null;
            }
        }

        public DataTable ConsultarLugarByComunaSinOtro(string IdComuna)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdComuna", Valor = IdComuna, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_Lugar_By_Comuna_Otro", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return null;
            }
        }

        public bool InsertarLugar(string dane, string nit, string tipoLugar, string tipoModalidad, string nombreLugar,
                                     string entorno, string comuna, string barrio, string direccion,
                                     string telefono1, string telefono2, string nombreResponsable,
                                     string idUsuarioCreacion, string idUsuarioModificacion)
        {
            try
            {
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdDane", Valor = dane, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdNit", Valor = nit, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@TipoLugar", Valor = tipoLugar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@TipoModalidad", Valor = tipoModalidad, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@NombreLugar", Valor = nombreLugar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdEntorno", Valor = entorno, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdComuna", Valor = comuna, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdBarrio", Valor = barrio, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Direccion", Valor = direccion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Telefono1", Valor = telefono1, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Telefono2", Valor = telefono2, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@NombreResponsable", Valor = nombreResponsable, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioModificacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaCreacion, Tipo = typeof(DateTime?) });


                objBd.ejecutarProcedimiento("dbop_AddTBL_LUGAR", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool ActualizarLugar(string idLugar, string dane, string nit, string tipoLugar, 
                                     string tipoModalidad, string nombreLugar,
                                     string entorno, string comuna, string barrio, string direccion,
                                     string telefono1, string telefono2, string nombreResponsable, 
                                     string idUsuarioModificacion)
        {
            try
            {
                DateTime fechaModificacion = DateTime.Now;

                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdLugar", Valor = idLugar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdDane", Valor = dane, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdNit", Valor = nit, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@TipoLugar", Valor = tipoLugar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@TipoModalidad", Valor = tipoModalidad, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@NombreLugar", Valor = nombreLugar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdEntorno", Valor = entorno, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdComuna", Valor = comuna, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdBarrio", Valor = barrio, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Direccion", Valor = direccion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Telefono1", Valor = telefono1, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Telefono2", Valor = telefono2, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@NombreResponsable", Valor = nombreResponsable, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioModificacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaModificacion, Tipo = typeof(DateTime?) });

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_LUGAR", parametros);
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