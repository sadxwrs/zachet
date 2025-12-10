using System;
using System.Data;
using System.Data.SqlClient;

namespace Zadanie52
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.Title = "Задание 5.2 – Products + Categories с отношением";
            string cs = "Server=DESKTOP-K8N2SVE\\SQLEXPRESS;Database=TestDB;Trusted_Connection=True;TrustServerCertificate=True;";

            DataSet ds = new DataSet("NorthwindMini");

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    SqlDataAdapter daCat = new SqlDataAdapter("SELECT CategoryID, CategoryName, Description FROM Categories", con);
                    daCat.Fill(ds, "Categories");

                    SqlDataAdapter daProd = new SqlDataAdapter("SELECT ProductID, ProductName, CategoryID, UnitPrice, UnitsInStock FROM Products", con);
                    daProd.Fill(ds, "Products");
                }

                DataRelation rel = new DataRelation("Categories_Products",
                    ds.Tables["Categories"].Columns["CategoryID"],
                    ds.Tables["Products"].Columns["CategoryID"],
                    false);

                ds.Relations.Add(rel);

                Console.WriteLine($"Категорий: {ds.Tables["Categories"].Rows.Count}");
                Console.WriteLine($"Товаров:   {ds.Tables["Products"].Rows.Count}");
                Console.WriteLine($"Создано отношение: {rel.RelationName}\n");

                Console.WriteLine(new string('=', 120));
                foreach (DataRow category in ds.Tables["Categories"].Rows)
                {
                    Console.WriteLine($"[{category["CategoryID"]}] {category["CategoryName"]}");
                    Console.WriteLine($"    Описание: {(category["Description"] == DBNull.Value ? "—" : category["Description"])}");

                    DataRow[] products = category.GetChildRows(rel);
                    if (products.Length == 0)
                        Console.WriteLine("        • товаров нет");
                    else
                        foreach (DataRow p in products)
                            Console.WriteLine($"        • {p["ProductID"],-3} {p["ProductName"],-40} {p["UnitPrice"],10:C}  остаток: {p["UnitsInStock"]}");

                    Console.WriteLine();
                }

                Console.WriteLine(new string('=', 120));
                Console.WriteLine("Все товары с названием категории:");
                Console.WriteLine("{0,-5} {1,-40} {2,-25} {3,12} {4,8}", "ID", "Товар", "Категория", "Цена", "Остаток");
                Console.WriteLine(new string('-', 120));

                foreach (DataRow p in ds.Tables["Products"].Rows)
                {
                    string cat = "—";
                    if (p["CategoryID"] != DBNull.Value)
                    {
                        DataRow parent = p.GetParentRow(rel);
                        if (parent != null) cat = parent["CategoryName"].ToString();
                    }

                    Console.WriteLine("{0,-5} {1,-40} {2,-25} {3,12:C} {4,8}",
                        p["ProductID"], p["ProductName"], cat, p["UnitPrice"], p["UnitsInStock"]);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Ошибка: " + ex.Message);
            }

            Console.WriteLine("\nГотово. Нажмите любую клавишу...");
            Console.ReadKey();
        }
    }
}