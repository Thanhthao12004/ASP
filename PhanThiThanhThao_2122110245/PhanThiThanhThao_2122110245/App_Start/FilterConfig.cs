using System.Web;
using System.Web.Mvc;

namespace PhanThiThanhThao_2122110245
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
