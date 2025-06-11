using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;

namespace BuenComienzo.Core.Administracion
{
    public class Perfiles
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

        public bool InsertarPerfil(string nombre, int? idPerfilPadre)
        {
            try
            {
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@NombrePerfil", Valor = nombre, Tipo = typeof(string) });

                objBd.ejecutarProcedimiento("dbop_AddTBL_PERFILES", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool ActualizarPerfil(int idPerfil, string nombre, int? idPerfilPadre)
        {
            try
            {
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdPerfil", Valor = idPerfil, Tipo = typeof(int) });
                parametros.Add(new Parametro { NombreParametro = "@NombrePerfil", Valor = nombre, Tipo = typeof(string) });

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_PERFILES", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }
        public bool EliminarPerfil(int idPerfil)
        {
            try
            {
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdPerfil", Valor = idPerfil, Tipo = typeof(int) });

                objBd.ejecutarProcedimiento("dbop_DeleteTBL_PERFILES", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public DataTable ObtenerPerfil(int idPerfil)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdPerfil", Valor = idPerfil, Tipo = typeof(int) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_PERFILES", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarPerfiles()
        {
            try
            {
                DataTable dtDatos;

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetAllTBL_PERFILES", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public enum perfiles {
            Administrador = 1,
            Agente = 2,
            Supervisor= 3,
            Bibliotecario = 4,
            Ludotecario = 5,
            Sisben = 6,
            ManaInfantil = 7,
            Simat = 8,
            Victimas = 9,
            AuxiliarAdministrativo = 10
        }
    }
}
