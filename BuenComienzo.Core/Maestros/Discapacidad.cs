﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;

namespace BuenComienzo.Core.Maestros
{
    public class Discapacidad
    {
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public DataTable Consultar()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("SELECT * FROM TBL_MAEDISCAPACIDAD").Tables[0];
            return dtDatos;
        }

    }
}
