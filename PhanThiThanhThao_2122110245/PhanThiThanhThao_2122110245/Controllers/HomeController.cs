using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PhanThiThanhThao_2122110245.Context;
using PhanThiThanhThao_2122110245.Models;
namespace PhanThiThanhThao_2122110245.Controllers
{
    public class HomeController : Controller
    {
        BanHangEntities objBanHangEntities = new BanHangEntities();
        public ActionResult Index()
        {

            HomeModel objHomeModel = new HomeModel();
            objHomeModel.listCategory = objBanHangEntities.Categories.ToList();

            //objHomeModel.lstProduct = objBanHangEntities.Products.ToList();
            return View(objHomeModel);
        }


        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}