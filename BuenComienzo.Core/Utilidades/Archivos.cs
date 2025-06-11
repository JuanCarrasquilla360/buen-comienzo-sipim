using BuenComienzo.AccesoDatos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Utilidades2
{
    public class Archivos
    {
        private string strError;
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();
        public int Insertar(string TipoArchivo,
                            int idPadre,
                            string nombreArchivo,
                            string Extension,
                            string strGuid,
                            string IdUsuarioCreacion,
                            ref int intError,
                            ref string strError)
        {
            try
            {


                int idArchivo = 0;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@TipoArchivo", Valor = TipoArchivo, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@idPadre", Valor = idPadre, Tipo = typeof(int) });
                parametros.Add(new Parametro { NombreParametro = "@NombreArchivo", Valor = nombreArchivo, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Extension", Valor = Extension, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Guid", Valor = strGuid, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@idUsuarioCreacion", Valor = IdUsuarioCreacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@OUT_intError", Valor = intError, Tipo = typeof(int), IsOutput = true });
                parametros.Add(new Parametro { NombreParametro = "@OUT_strError", Valor = strError, Tipo = typeof(string), IsOutput = true });
                parametros.Add(new Parametro { NombreParametro = "@idArchivo", Valor = idArchivo, Tipo = typeof(int), IsOutput = true });

                if (objBd.ejecutarProcedimientoIUD("dbop_UpSertTBL_ARCHIVOS", parametros, ref intError, ref strError, "@idArchivo", ref idArchivo))
                {
                    return idArchivo;
                }
                else
                {
                    return 0;
                }

            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return 0;
            }
        }
    }
}
