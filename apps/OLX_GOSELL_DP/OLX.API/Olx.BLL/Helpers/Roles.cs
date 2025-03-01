using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Olx.BLL.Helpers
{
    public static class Roles
    {
        public const string Admin = "Admin";
        public const string User = "User";
        public static IEnumerable<string> Get() => typeof(Roles).GetFields(BindingFlags.Public | BindingFlags.Static |
               BindingFlags.FlattenHierarchy).Select(x => (string)x.GetValue(null)!);
    }
}
