using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Data.SqlClient;
using FleetManagement.Services;
using FleetManagement.Entities;
using FleetManagement.Interfaces;
using System.Collections.Generic;
using FleetManagement.Common;
using FleetManagement.Enums;
using System.Linq;

public partial class Clientbooking : System.Web.UI.Page
{
    IEntityService<Customer> customerService = new CustomerService();
    IEntityService<VehicleType> vehicleTypeService = new VehicleTypeService();
    IVehicleService vehicleService = new VehicleService();
    ICustomerBookingService customerBookingService = new CustomerBookingService();
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMessage.Visible = false;
        if (!IsPostBack)
        {
            BindVehicleTypes();
            BindCustomers();
            BindFuelType();
            BindAC();
                     
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //check if we have available vehicle
        int vehicleType = int.Parse(ddlVehicletype.SelectedValue);
        int fuelType = int.Parse(ddlFueltype.SelectedValue);
        bool ac = int.Parse(ddlAc.SelectedValue) == (int)FleetManagement.Enums.YesNo.Yes ? true:false;
        DateTime fromDate = txtFromdate.Text.ToDateTime();
        DateTime toDate = txtTodate.Text.ToDateTime();
        bool driverNeeded = chkDriverNeeded.Checked;

        int vehicleToAllocate = 0, tariffID = 0;
        int? driverToAllocate = null;
       VehicleAvailabilityStatus vehicleAvailStatus = vehicleService.ChooseVehicleForAllocation(vehicleType, fuelType, ac,driverNeeded, fromDate, toDate, out vehicleToAllocate, out driverToAllocate,out tariffID);

       if (vehicleAvailStatus == VehicleAvailabilityStatus.NONE)
       {
           lblMessage.Text = "No vehicles are available for booking for selected dates";
           lblMessage.Visible = true;
           return;
       }
       else if (vehicleAvailStatus == VehicleAvailabilityStatus.AllBooked)
       {
           lblMessage.Text = "No vehicles are available for booking for selected dates";
           lblMessage.Visible = true;
           return;
       }
       else if (vehicleAvailStatus == VehicleAvailabilityStatus.NotAvailableForSelectedOptions)
       {
           lblMessage.Text = "No vehicles are available for selected options (Vehicle name, AC and FuelType). Try changing the options!";
           lblMessage.Visible = true;
           return;
       }
       else if (vehicleAvailStatus == VehicleAvailabilityStatus.NoDriverAvailable)
       {
           lblMessage.Text = "No Driver available. If you want to book without driver, please uncheck the Driver Needed checkbox and proceed!";
           lblMessage.Visible = true;
           return;
       }
       else if (vehicleAvailStatus == VehicleAvailabilityStatus.Available)
       {
           CustomerBooking customerBooking = new CustomerBooking();
           customerBooking.FromDate = fromDate;
           customerBooking.ToDate = toDate;
           customerBooking.Phone = txtPhoneno.Text;
           customerBooking.PickupPoint = txtPickup.Text;
           customerBooking.DropPoint = txtDroppoint.Text;
           customerBooking.GuestName = txtGuestname.Text;
           customerBooking.CustomerID = int.Parse(ddlCustomername.SelectedValue);
           customerBooking.BillingDetails = new CustomerBilling();
           customerBooking.BillingDetails.TariffID = tariffID;

           FleetManagement.Entities.VehicleAllocation vehicleAllocation = new FleetManagement.Entities.VehicleAllocation();
           vehicleAllocation.VehicleID = vehicleToAllocate;
           vehicleAllocation.EmployeeID = driverToAllocate;

           int bookingId = 0;
           if (customerBookingService.CreateCustomerBooking(customerBooking, vehicleAllocation, out bookingId))
           {
               //load booking again
               customerBooking = customerBookingService.Get(bookingId).FirstOrDefault();
               lblMessage.Text = "Booking created successfully. Your booking reference no is " + customerBooking.BookingRef;
               
               clearFields();
               lblMessage.Visible = true;
               return;
           }


       }

    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx");
    }
    private void BindVehicleTypes()
    {
        List<VehicleType> vehicleTypes = vehicleTypeService.Get();
        ddlVehicletype.Items.Clear();
        ddlVehicletype.Items.Add(new ListItem("Select", "0"));
        vehicleTypes.ForEach(c =>
        {
            ddlVehicletype.Items.Add(new ListItem(c.Name, c.ID.ToString()));
        });
    }
    private void BindFuelType()
    {
        ddlFueltype.Items.Clear();
        ddlFueltype.Items.AddRange(Common.ToListItems<FuelType>().ToArray());
    }
    private void BindAC()
    {
        ddlAc.Items.Clear();
        ddlAc.Items.AddRange(Common.ToListItems<YesNo>().ToArray());
    }
    private void BindCustomers()
    {
        List<Customer> customers = customerService.Get();
        ddlCustomername.Items.Clear();
        ddlCustomername.Items.Add(new ListItem("Select", "0"));
        customers.ForEach(c => {
            ddlCustomername.Items.Add(new ListItem(c.Name, c.ID.ToString()));
        });
    }
    private void clearFields()
    {
        ddlCustomername.SelectedIndex = 0;
        ddlAc.SelectedIndex = 0;
        ddlFueltype.SelectedIndex = 0;
        ddlNoOfSeating.SelectedIndex = 0;
        ddlVehicletype.SelectedIndex = 0;
        txtDroppoint.Text = string.Empty;
        txtFromdate.Text = string.Empty;
        txtGuestname.Text = string.Empty;
        txtPhoneno.Text = string.Empty;
        txtPickup.Text = string.Empty;
        txtTodate.Text = string.Empty;
    }
}
