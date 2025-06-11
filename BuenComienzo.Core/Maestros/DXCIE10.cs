using BuenComienzo.AccesoDatos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Maestros
{
    public class DXCIE10
    {
        private string strError;
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();
        public DataTable Consultar()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("select IdDXCIE10, IdDXCIE10 + ' - ' + NombreDXCIE as NombreDXCIE from TBL_DXCIE10").Tables[0];
            return dtDatos;
        }
    }
}
