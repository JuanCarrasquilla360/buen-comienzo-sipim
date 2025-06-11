using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;

namespace BuenComienzo.Core.Maestros
{
    public class EntidadActivacionRuta
    {
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public DataTable Consultar()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("select * from [dbo].[TBL_MAEENTIDADACTIVACIONRUTA] WHERE IdMaeEntidadActivacionRuta <> 11 and activo = 1 UNION ALL select * from [dbo].[TBL_MAEENTIDADACTIVACIONRUTA] WHERE IdMaeEntidadActivacionRuta = 11 and activo = 1").Tables[0];
            return dtDatos;
        }

    }
}
