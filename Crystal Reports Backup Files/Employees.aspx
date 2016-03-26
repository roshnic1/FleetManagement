<%@ Page Language="C#" MasterPageFile="~/Fleetmanagement.master" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="Employees" Title="Untitled Page" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<%--For Calender--%>
<table class="ds_box" cellpadding="0" cellspacing="0" id="ds_conclass" style="display: none;">
<tr><td id="ds_calclass">
</td></tr>
</table>

<script type="text/javascript">

// <!-- <![CDATA[

// Project: Dynamic Date Selector (DtTvB) - 2006-03-16
// Script featured on JavaScript Kit- http://www.javascriptkit.com
// Code begin...
// Set the initial date.
var ds_i_date = new Date();
ds_c_month = ds_i_date.getMonth() + 1;
ds_c_year = ds_i_date.getFullYear();

// Get Element By Id
function ds_getel(id) {
	return document.getElementById(id);
}

// Get the left and the top of the element.
function ds_getleft(el) {
	var tmp = el.offsetLeft;
	el = el.offsetParent
	while(el) {
		tmp += el.offsetLeft;
		el = el.offsetParent;
	}
	return tmp;
}
function ds_gettop(el) {
	var tmp = el.offsetTop;
	el = el.offsetParent
	while(el) {
		tmp += el.offsetTop;
		el = el.offsetParent;			
	}
	return tmp;
}

// Output Element
var ds_oe = ds_getel('ds_calclass');
// Container
var ds_ce = ds_getel('ds_conclass');

// Output Buffering
var ds_ob = ''; 
function ds_ob_clean() {
	ds_ob = '';
}
function ds_ob_flush() {
	ds_oe.innerHTML = ds_ob;
	ds_ob_clean();
}
function ds_echo(t) {
	ds_ob += t;
}

var ds_element; // Text Element...

var ds_monthnames = [
'January', 'February', 'March', 'April', 'May', 'June',
'July', 'August', 'September', 'October', 'November', 'December'
]; // You can translate it for your language.

var ds_daynames = [
'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
]; // You can translate it for your language.

// Calendar template
function ds_template_main_above(t) {
	return '<table cellpadding="3" cellspacing="1" class="ds_tbl">'
	     + '<tr>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_py();">&lt;&lt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_pm();">&lt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_hi();" colspan="3">[Close]</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_nm();">&gt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_ny();">&gt;&gt;</td>'
		 + '</tr>'
	     + '<tr>'
		 + '<td colspan="7" class="ds_head">' + t + '</td>'
		 + '</tr>'
		 + '<tr>';
}

function ds_template_day_row(t) {
	return '<td class="ds_subhead">' + t + '</td>';
	// Define width in CSS, XHTML 1.0 Strict doesn't have width property for it.
}

function ds_template_new_week() {
	return '</tr><tr>';
}

function ds_template_blank_cell(colspan) {
	return '<td colspan="' + colspan + '"></td>'
}

function ds_template_day(d, m, y) {
	return '<td class="ds_cell" onclick="ds_onclick(' + d + ',' + m + ',' + y + ')">' + d + '</td>';
	// Define width the day row.
}

function ds_template_main_below() {
	return '</tr>'
	     + '</table>';
}

// This one draws calendar...
function ds_draw_calendar(m, y) {
	// First clean the output buffer.
	ds_ob_clean();
	// Here we go, do the header
	ds_echo (ds_template_main_above(ds_monthnames[m - 1] + ' ' + y));
	for (i = 0; i < 7; i ++) {
		ds_echo (ds_template_day_row(ds_daynames[i]));
	}
	// Make a date object.
	var ds_dc_date = new Date();
	ds_dc_date.setMonth(m - 1);
	ds_dc_date.setFullYear(y);
	ds_dc_date.setDate(1);
	if (m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12) {
		days = 31;
	} else if (m == 4 || m == 6 || m == 9 || m == 11) {
		days = 30;
	} else {
		days = (y % 4 == 0) ? 29 : 28;
	}
	var first_day = ds_dc_date.getDay();
	var first_loop = 1;
	// Start the first week
	ds_echo (ds_template_new_week());
	// If sunday is not the first day of the month, make a blank cell...
	if (first_day != 0) {
		ds_echo (ds_template_blank_cell(first_day));
	}
	var j = first_day;
	for (i = 0; i < days; i ++) {
		// Today is sunday, make a new week.
		// If this sunday is the first day of the month,
		// we've made a new row for you already.
		if (j == 0 && !first_loop) {
			// New week!!
			ds_echo (ds_template_new_week());
		}
		// Make a row of that day!
		ds_echo (ds_template_day(i + 1, m, y));
		// This is not first loop anymore...
		first_loop = 0;
		// What is the next day?
		j ++;
		j %= 7;
	}
	// Do the footer
	ds_echo (ds_template_main_below());
	// And let's display..
	ds_ob_flush();
	// Scroll it into view.
	ds_ce.scrollIntoView();
}

// A function to show the calendar.
// When user click on the date, it will set the content of t.
function ds_sh(t) {
    
    //hiding dropdownlists while calender popup
     var elem=document.getElementById("<%=ddlQualification.ClientID %>");        
    elem.style.display='none';    
    
     var elem=document.getElementById("<%=ddlCountry.ClientID %>");        
    elem.style.display='none';  
	// Set the element to set...
	ds_element = t;
	// Make a new date, and set the current month and year.
	var ds_sh_date = new Date();
	ds_c_month = ds_sh_date.getMonth() + 1;
	ds_c_year = ds_sh_date.getFullYear();
	// Draw the calendar
	ds_draw_calendar(ds_c_month, ds_c_year);
	// To change the position properly, we must show it first.
	ds_ce.style.display = '';
	// Move the calendar container!
	the_left = ds_getleft(t);
	the_top = ds_gettop(t) + t.offsetHeight;
	ds_ce.style.left = the_left + 'px';
	ds_ce.style.top = the_top + 'px';
	// Scroll it into view.
	ds_ce.scrollIntoView();
}


function ds_hh(t) {
    var elem=document.getElementById("<%=ddlQualification.ClientID %>");        
    elem.style.display='block';
    
    //hiding dropdownlists while calender popup     
    
     var elem=document.getElementById("<%=ddlCountry.ClientID %>");        
    elem.style.display='none';  
	// Set the element to set...
	ds_element = t;
	// Make a new date, and set the current month and year.
	var ds_sh_date = new Date();
	ds_c_month = ds_sh_date.getMonth() + 1;
	ds_c_year = ds_sh_date.getFullYear();
	// Draw the calendar
	ds_draw_calendar(ds_c_month, ds_c_year);
	// To change the position properly, we must show it first.
	ds_ce.style.display = '';
	// Move the calendar container!
	the_left = ds_getleft(t);
	the_top = ds_gettop(t) + t.offsetHeight;
	ds_ce.style.left = the_left + 'px';
	ds_ce.style.top = the_top + 'px';
	// Scroll it into view.
	ds_ce.scrollIntoView();
}


// Hide the calendar.
function ds_hi() {
    //displaying dropdownlists
     var elem=document.getElementById("<%=ddlQualification.ClientID %>");        
    elem.style.display='block';  
    
     var elem=document.getElementById("<%=ddlCountry.ClientID %>");        
    elem.style.display='block';  
    
	ds_ce.style.display = 'none';
}

// Moves to the next month...
function ds_nm() {
	// Increase the current month.
	ds_c_month ++;
	// We have passed December, let's go to the next year.
	// Increase the current year, and set the current month to January.
	if (ds_c_month > 12) {
		ds_c_month = 1; 
		ds_c_year++;
	}
	// Redraw the calendar.
	ds_draw_calendar(ds_c_month, ds_c_year);
}

// Moves to the previous month...
function ds_pm() {
	ds_c_month = ds_c_month - 1; // Can't use dash-dash here, it will make the page invalid.
	// We have passed January, let's go back to the previous year.
	// Decrease the current year, and set the current month to December.
	if (ds_c_month < 1) {
		ds_c_month = 12; 
		ds_c_year = ds_c_year - 1; // Can't use dash-dash here, it will make the page invalid.
	}
	// Redraw the calendar.
	ds_draw_calendar(ds_c_month, ds_c_year);
}

// Moves to the next year...
function ds_ny() {
	// Increase the current year.
	ds_c_year++;
	// Redraw the calendar.
	ds_draw_calendar(ds_c_month, ds_c_year);
}

// Moves to the previous year...
function ds_py() {
	// Decrease the current year.
	ds_c_year = ds_c_year - 1; // Can't use dash-dash here, it will make the page invalid.
	// Redraw the calendar.
	ds_draw_calendar(ds_c_month, ds_c_year);
}

// Format the date to output.
function ds_format_date(d, m, y) {
	// 2 digits month.
	m2 = '00' + m;
	m2 = m2.substr(m2.length - 2);
	// 2 digits day.
	d2 = '00' + d;
	d2 = d2.substr(d2.length - 2);
	// YYYY-MM-DD
//	return y + '-' + m2 + '-' + d2;
	return m2 + '/' + d2+ '/' + y;
}

// When the user clicks the day.
function ds_onclick(d, m, y) {
	// Hide the calendar.
	ds_hi();
	// Set the value of it, if we can.
	if (typeof(ds_element.value) != 'undefined') {
		ds_element.value = ds_format_date(d, m, y);
	// Maybe we want to set the HTML in it.
	} else if (typeof(ds_element.innerHTML) != 'undefined') {
		ds_element.innerHTML = ds_format_date(d, m, y);
	// I don't know how should we display it, just alert it to user.
	} else {
		alert (ds_format_date(d, m, y));
	}
}

// And here is the end.

// ]]> -->
</script>


<%--ADD EMPLOYEE DETAILS--%>

    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">Add Employee Details</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading"></div>
                <div class="panel-body">                  
                    <table align="center">
                        <tr>
                            <td colspan="3" align="center"><h3></h3></td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center">
                                <asp:Label ID="lblMessage" runat="server" Visible="False" CssClass="lblMessage"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblFirstName" runat="server" Text="First Name" meta:resourcekey="lblFirstNameResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox CssClass="form-control" ID="txtFirstname" runat="server" meta:resourcekey="txtFirstnameResource1"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtFirstname" meta:resourcekey="RequiredFieldValidator1Resource1" SetFocusOnError="True">Firstname Required</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblLastname" runat="server" Text="Last Name" meta:resourcekey="lblLastnameResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form-control" ID="txtLastName" runat="server" meta:resourcekey="txtLastNameResource1"></asp:TextBox></td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="txtLastName" meta:resourcekey="RequiredFieldValidator2Resource1" SetFocusOnError="True">Lastname Required</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDesignation" runat="server" Text="Designation" meta:resourcekey="lblDesignationResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList CssClass="from-control input-sm" ID="ddlDesignation" runat="server" meta:resourcekey="ddlDesignationResource1">
                                    <asp:ListItem meta:resourcekey="ListItemResource1">Select</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource2">Manager</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource3">Supervisor</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource4">Driver</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="ddlDesignation" meta:resourcekey="RequiredFieldValidator3Resource1" SetFocusOnError="True">Select</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSalery" runat="server" Text="Salary" meta:resourcekey="lblSaleryResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form-control" ID="txtSalery" runat="server" meta:resourcekey="txtSaleryResource1" MaxLength="12"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="txtSalery" meta:resourcekey="RequiredFieldValidator4Resource1"></asp:RequiredFieldValidator><asp:CompareValidator
            ID="CompareValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtSalery" Operator="DataTypeCheck" Type="Integer">Eg: 10000</asp:CompareValidator>
    &nbsp;<%--<asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtSalery" MaximumValue="9" MinimumValue="0" Type="Integer"></asp:RangeValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDateofjoin" runat="server" Text="Date of Join" meta:resourcekey="lblDateofjoinResource1"></asp:Label>
                            </td>
                            <td>
                                <input class="form-control" onclick="ds_sh(this);" name="date" onfocus="ds_sh(this)"  runat="server" style="cursor: text"  id="txtJoiningdate" readonly="readOnly" />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ControlToValidate="txtJoiningdate" meta:resourcekey="RequiredFieldValidator5Resource1">Date Required</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblQualification" runat="server" Text="Qualification" meta:resourcekey="lblQualificationResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList CssClass="from-control input-sm" ID="ddlQualification" runat="server" meta:resourcekey="ddlQualificationResource1">
                                    <asp:ListItem Value="Select" meta:resourcekey="ListItemResource5">Select</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource6">Tenth</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource7">B.A</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource8">BCA</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource9">B.Com</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource10">B.Sc</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource11">Diploma</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource12">MBA</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource13">M.Com</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource14">M.Sc</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" ControlToValidate="ddlQualification" meta:resourcekey="RequiredFieldValidator6Resource1">Select</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDateofbirth" runat="server" Text="DOB" meta:resourcekey="lblDateofbirthResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form-control" ID="txtDob" onclick="ds_hh(this)" onfocus="ds_hh(this)"  runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*" ControlToValidate="txtDob">Date Required</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblAddress" runat="server" Text="Address" meta:resourcekey="lblAddressResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form-control" ID="txtAddress" runat="server" TextMode="MultiLine" meta:resourcekey="txtAddressResource1"></asp:TextBox></td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="*" ControlToValidate="txtAddress" meta:resourcekey="RequiredFieldValidator8Resource1">Address Required</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblCountry" runat="server" Text="Country " meta:resourcekey="lblCountryResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList CssClass="from-control input-sm" ID="ddlCountry" runat="server" meta:resourcekey="ddlCountryResource1">
                                    <asp:ListItem Value="0" meta:resourcekey="ListItemResource15">Select</asp:ListItem>
                                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource16">India</asp:ListItem>
                                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource17">Others</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="*" ControlToValidate="ddlCountry" meta:resourcekey="RequiredFieldValidator9Resource1">Select</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblState" runat="server" Text="State" meta:resourcekey="lblStateResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox CssClass="form-control" ID="txtState" runat="server" meta:resourcekey="txtStateResource1"></asp:TextBox></td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="*" ControlToValidate="txtState" meta:resourcekey="RequiredFieldValidator10Resource1">State Required</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblPhone" runat="server" Text="Contact No" meta:resourcekey="lblPhoneResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form-control" ID="txtContactno" runat="server" meta:resourcekey="txtContactnoResource1" MaxLength="13"></asp:TextBox></td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*" ControlToValidate="txtContactno" meta:resourcekey="RequiredFieldValidator11Resource1"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtContactno" SetFocusOnError="True" ValidationExpression="^([0-9]( |-)?)?(\(?[0-9]{3}\)?|[0-9]{3})( |-)?([0-9]{3}( |-)?[0-9]{4}|[a-zA-Z0-9]{7})$"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblEmailid" runat="server" Text="Email Id" meta:resourcekey="lblEmailidResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form-control" ID="txtEmailid" runat="server" meta:resourcekey="txtEmailidResource1"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="*" ControlToValidate="txtEmailid" meta:resourcekey="RequiredFieldValidator12Resource1"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator id="RegularExpressionValidator2" runat="server" SetFocusOnError="True" ControlToValidate="txtEmailid" ErrorMessage="*" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">Eg: proj@g.com</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center">
                                <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />&nbsp;
                                <asp:Button ID="btnBack" CssClass="btn btn-primary" runat="server" Text="Back" PostBackUrl="~/Home.aspx" CausesValidation="False" meta:resourcekey="btnBackResource1" />
                            </td>  
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
