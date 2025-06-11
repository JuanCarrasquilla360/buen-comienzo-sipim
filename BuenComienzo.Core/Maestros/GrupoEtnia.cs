using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;

namespace BuenComienzo.Core.Maestros
{
    public class GrupoEtnia
    {
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public DataTable ConsultarGrupoEtnia()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("SELECT * FROM VIEW_GRUPOETNIA ORDER BY IdGrupoEtnico ASC").Tables[0];
            return dtDatos;
        }
    }
}
