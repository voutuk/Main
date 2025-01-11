using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _18_E_LEARN.BusinessLogic.Services
{
    public class ServiceResponse
    {
        public string Message { get; set; }
        public bool Success { get; set; }
        public object Payload { get; set; }
        public IEnumerable<string> Errors { get; set; }
    }
}
