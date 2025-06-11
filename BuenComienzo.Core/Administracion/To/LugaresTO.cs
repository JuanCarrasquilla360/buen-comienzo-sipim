using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Administracion.To
{
    public class LugaresTO
    {
        public int IdLugar { get; set; }
        public string IdDane { get; set; }
        public string IdNit { get; set; }
        public string TipoLugar { get; set; }
        public string TipoModalidad { get; set; }
        public string NombreLugar { get; set; }
        public string IdEntorno { get; set; }
        public string IdComuna { get; set; }
        public string IdBarrio { get; set; }
        public string Direccion { get; set; }
        public string Telefono1 { get; set; }
        public string Telefono2 { get; set; }
        public string PrestacionServicio { get; set; }
        public string Zona { get; set; }
        public string CorreoElectronico { get; set; }
        public string NombreResponsable { get; set; }
        public string Nucleo { get; set; }
        public string IdProfesionalPsicologia { get; set; }
        public string IdUsuarioCreacion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string IdUsuarioModificacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }
}
