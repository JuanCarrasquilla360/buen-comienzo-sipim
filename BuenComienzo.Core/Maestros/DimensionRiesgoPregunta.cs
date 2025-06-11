using BuenComienzo.AccesoDatos;
using BuenComienzo.Core.Maestros.To;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Maestros
{
    public class DimensionRiesgoPregunta
    {
        private string strError;
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public List<DimensionRiesgoPreguntaTO> getPreguntas(int idCaracterizacion)
        {
            try
            {
                List<DimensionRiesgoPreguntaTO> tOs = new List<DimensionRiesgoPreguntaTO>();
                tOs = Utilidades.ToList<DimensionRiesgoPreguntaTO>(ObtenerPreguntas(idCaracterizacion));
                return tOs;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerPreguntas(int IdCaracterizacion)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdCaracterizacionFamiliar", Valor = IdCaracterizacion, Tipo = typeof(int) });
                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_TBL_MAEDIMENSIONXRIESGOXPREGUNTAS", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public int Insertar(int IdCaracterizacionFamiliar,
                           int idPregunta,
                           string Respuesta,
                           string IdUsuarioCreacion,
                           ref int intError,
                           ref string strError)
        {
            try
            {


                int IdCaracterizacionDetallePregunta = 0;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdCaracterizacionFamiliar", Valor = IdCaracterizacionFamiliar, Tipo = typeof(int) });
                parametros.Add(new Parametro { NombreParametro = "@idPregunta", Valor = idPregunta, Tipo = typeof(int) });
                parametros.Add(new Parametro { NombreParametro = "@Respuesta", Valor = Respuesta, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = IdUsuarioCreacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@OUT_intError", Valor = intError, Tipo = typeof(int), IsOutput = true });
                parametros.Add(new Parametro { NombreParametro = "@OUT_strError", Valor = strError, Tipo = typeof(string), IsOutput = true });
                parametros.Add(new Parametro { NombreParametro = "@IdCaracterizacionDetallePregunta", Valor = IdCaracterizacionDetallePregunta, Tipo = typeof(int), IsOutput = true });

                if (objBd.ejecutarProcedimientoIUD("dbop_AddTBL_CARACTERIZACIONFAMILIARDETALLEPREGUNTA", parametros, ref intError, ref strError, "@IdCaracterizacionDetallePregunta", ref IdCaracterizacionDetallePregunta))
                {
                    return IdCaracterizacionDetallePregunta;
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
