using BuenComienzo.AccesoDatos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Maestros
{
    public class Procedimientos_SSR
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
        public DataTable Consultar()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("select * from TBL_PROCEDIMIENTOS_SSR where Estado = 1").Tables[0];
            return dtDatos;
        }
    }
}
