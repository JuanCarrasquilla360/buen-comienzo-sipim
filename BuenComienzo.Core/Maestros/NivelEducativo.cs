﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;

namespace BuenComienzo.Core.Maestros
{
    public class NivelEducativo
    {
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public DataTable ConsultarNivelEducativo()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("SELECT * FROM VIEW_NIVELEDUCATIVO ORDER BY IdNivelEducativo ASC").Tables[0];
            return dtDatos;
        }
    }
}
