using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;

namespace BuenComienzo.Core.Maestros
{
    public class TipoDocumento
    {
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public DataTable ConsultarTipoDocumento()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("SELECT * FROM VIEW_TIPODOCUMENTO ORDER BY idMaeTipoDocumento ASC").Tables[0];
            return dtDatos;
        }

        public DataTable ConsultarTipoDocumentoAdulto()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("SELECT * FROM VIEW_TIPODOCUMENTOADULTO ORDER BY idMaeTipoDocumento ASC").Tables[0];
            return dtDatos;
        }


    }
}
