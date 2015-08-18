using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//Class: <CMIS485 6380 Web Database Development (2152) >
//Student Name: David Walters
//Instructor: <Dr. Alla Webb>
//Assignment #: Project 2
//Description: This application allows the create, read, update and delete functions to a basic customer database
//    for Reston Real Estate company. This file- Sales.aspx.cs is the 'CodeBehind' page that allows functions to be called
//    and compiled on the server.
//Due Date :<3/8/2015>
//I pledge that I have completed the programming assignment independently.
//I have not copied the code from a student or any source.
//I have not given my code to any student.
//Sign here: David Walters
public partial class _Default : System.Web.UI.Page
{
    int totalSales = 0;
    int avgSale = 0;
    int totalSaleAmt = 0;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    //The following methods update the CustomersView GridView when an action is taken (update, insert or delete)
    protected void SaleFormView_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        SalesView.DataBind();
    }
    protected void SaleFormView_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        SalesView.DataBind();
    }
    protected void SaleFormView_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        SalesView.DataBind();
    }

    //The following methods are data validation methods on the inserting and updating of data into the Sales table from SalesFormView.
    protected void NotEmpty_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (args.Value.Length > 1)
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
    }
    protected void IsNumeric_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (Regex.IsMatch(args.Value, @"^\d+$") && args.Value.Length != 0)
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
    }
    protected void SaleDate_ServerValidate(object source, ServerValidateEventArgs args)
    {
        try
        {
            //Checks to see if user inputted correct date format. If no errors are thrown, entry is validated.
            DateTime.ParseExact(args.Value, "dd/mm/yyyy",
                DateTimeFormatInfo.InvariantInfo);
            args.IsValid = true;
        }
        catch
        {
            //If errors are thrown, entry is not validated.
            args.IsValid = false;
        }
    }
    //
    protected void NewRecordButton_Click(object sender, EventArgs e)
    {
        //Changes the FormView to Insert mode when NewRecordButton is clicked.
        SalesFormView.ChangeMode(FormViewMode.Insert);
    }
}