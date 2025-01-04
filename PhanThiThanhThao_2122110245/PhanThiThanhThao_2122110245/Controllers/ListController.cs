using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PhanThiThanhThao_2122110245.Controllers
{
    public class ListController : Controller
    {
        // GET: List
        public ActionResult ListGrid()
        {
            return View();
        }

        public ActionResult ListLagre()
        {
            return View();
        }
    }
}