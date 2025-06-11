using BuenComienzo.AccesoDatos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Administracion
{
    public class TipoCamposReporte
    {
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public DataTable ConsultarTipoCamposReporte()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("SELECT * FROM VIEW_TIPOCAMPOSREPORTE ORDER BY Nombre ASC").Tables[0];
            return dtDatos;
        }
    }
}
