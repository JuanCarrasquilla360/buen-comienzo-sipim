using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Maestros.To
{
    public class InfoIntervencionTO
    {
        public int IdDimension { get; set; }
        public string Dimension { get; set; }
        public int IdPerfil { get; set; }
        public string NombrePerfil { get; set; }
        public int IdRiesgo { get; set; }
        public string Riesgo { get; set; }
        public int IdIntervencion { get; set; }
        public string Intervencion { get; set; }
    }
}
