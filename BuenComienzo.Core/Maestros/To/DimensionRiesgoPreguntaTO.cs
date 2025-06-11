using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Maestros.To
{
    public class DimensionRiesgoPreguntaTO
    {
        public int IdMaeDimension { get; set; }
        public string Dimension { get; set; }
        public int IdMaeDimensionXRiesgo { get; set; }
        public string Riesgo { get; set; }
        public int IdMaePregunta { get; set; }
        public string Pregunta { get; set; }
        public string Respuesta { get; set; }

    }
}
