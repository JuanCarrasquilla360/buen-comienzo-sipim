using BuenComienzo.AccesoDatos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Maestros
{
    public class TipoVisitaPriorizada
    {
        private string strError;
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();
        public DataTable ConsultarVisitas()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("Select * from TBL_MAEVISITAPRIORIZADA WHERE Activo = 1").Tables[0];
            return dtDatos;
        }
    }
}
