using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.AccesoDatos
{
    public class Parametro
    {
        private string nombreParametro;

        private object valor;

        private Type tipo;

        private bool isOutput = false;

        public bool IsOutput {
            get {
                return this.isOutput;
            }
            set {
                this.isOutput = value;
            }
        }

        public string NombreParametro
        {
            get
            {
                return this.nombreParametro;
            }
            set
            {
                this.nombreParametro = value;
            }
        }

        public Type Tipo
        {
            get
            {
                return this.tipo;
            }
            set
            {
                this.tipo = value;
            }
        }

        public object Valor
        {
            get
            {
                return this.valor;
            }
            set
            {
                this.valor = value;
            }
        }

        public Parametro()
        {
        }
    }
}
