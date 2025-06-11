using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;

namespace BuenComienzo.Core.Maestros
{
    public class TipologiaFamiliar
    {
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public DataTable ConsultarTipologiaFamiliar()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("SELECT * FROM VIEW_TIPOLOGIAFAMILIAR ORDER BY IdMaeTipologiaFamiliar ASC").Tables[0];
            return dtDatos;
        }
    }
}
