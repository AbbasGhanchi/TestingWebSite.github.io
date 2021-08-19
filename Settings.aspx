<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Settings.aspx.cs" Inherits="Cpanel_Settings"
    EnableEventValidation="true" ValidateRequest="false" %>

<%@ Register Src="UI/Header.ascx" TagName="Header" TagPrefix="uc1" %>
<%@ Register Src="UI/Left.ascx" TagName="Left" TagPrefix="uc2" %>
<%@ Register Src="~/Cpanel/UI/CssJS.ascx" TagName="CssJs" TagPrefix="uc4" %>
<%@ Register Src="UI/LeftMobile.ascx" TagName="LeftMobile" TagPrefix="uc3" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Settings</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <uc4:CssJs runat="server" ID="cssjs1" />
    <script src="../js/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        function OpenBranchList() {
            var url = '../Cpanel/LrAutoNoDisableBranchWise.aspx';
            GB_showCenter('Branch List', url, 500, 1000)
        }

        function validateEmail(field) {
            var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,5}$/;
            return (regex.test(field)) ? true : false;
        }
        function validateMultipleEmailsCommaSeparated(emailcntl, seperator) {
            var value = emailcntl.value; c
            if (value != '') {
                var result = value.split(seperator);
                for (var i = 0; i < result.length; i++) {
                    if (result[i] != '') {
                        if (!validateEmail(result[i])) {
                            alert('Please check, `' + result[i] + '` email addresses not valid!');
                            emailcntl.focus();
                            return false;
                        }
                    }
                }
            }
            return true;
        }
        function DisplayRoyaltyDetaildiv(val) {
            if (val) {
                document.getElementById("div_Royalty").style.display = 'block';
            }
            else {
                document.getElementById("div_Royalty").style.display = 'none'; //.display = 'none';
            }
        }
        function AllowAlphabet(e) {
            if (e.keyCode == 9) {
                //TAB is pressed keyCode = 9 for TAB key
                return true;
            }
            else {
                return false;
            }
        }
        $j(document).ready(function () {
            $j('.numeric').keypress(function (event) {
                var Key = (event.keyCode ? event.keyCode : event.which);
                //alert(Key);
                if (Key != 9 && Key != 8 && Key != 46 && (Key < 48
                    || Key > 57)) {
                    event.preventDefault();
                } // prevent if not number/dot
                if (Key == 46 && $(this).val().indexOf('.') != -1) {
                    event.preventDefault();
                } // prevent if already dot
            });

            //$j("#tb_LessDeductionPer").focusout(functionForpercentage);
            isPaymentModeWithBillOn();
            DisplayFreightAt();
            BindSMSAPIHostName();
            DisplayCashPaymentLimit();
            DisplayLockBasedOnDays();
            DisplayOrderExpectedDateBasedOnTransistDays();
            $j("#ddl_SmsApiHostName").on('change', function () {
                BindSMSAPIHostName();
            });


            //Start Dt:05/11/2019
            $j('#cb_IsReqAgentInPRS').change(function () {
                if (this.checked) {
                    $j('#cb_IsDisAgentInPRS').prop("checked", true);
                }
            });

            $j('#cb_IsDisAgentInPRS').change(function () {
                if (!this.checked) {
                    $j('#cb_IsReqAgentInPRS').prop("checked", false);
                }
            });

            $j('#cb_IsReqBrokerInPRS').change(function () {
                if (this.checked) {
                    $j('#cb_IsDisBrokerInPRS').prop("checked", true);
                }
            });

            $j('#cb_IsDisBrokerInPRS').change(function () {
                if (!this.checked) {
                    $j('#cb_IsReqBrokerInPRS').prop("checked", false);
                }
            });

            $j('#cb_IsReqAgentInITC').change(function () {
                if (this.checked) {
                    $j('#cb_IsDisAgentInITC').prop("checked", true);
                }
            });

            $j('#cb_IsDisAgentInITC').change(function () {
                if (!this.checked) {
                    $j('#cb_IsReqAgentInITC').prop("checked", false);
                }
            });

            $j('#cb_IsReqAgentInDRS').change(function () {
                if (this.checked) {
                    $j('#cb_IsDisAgentInDRS').prop("checked", true);
                }
            });

            $j('#cb_IsDisAgentInDRS').change(function () {
                if (!this.checked) {
                    $j('#cb_IsReqAgentInDRS').prop("checked", false);
                }
            });
            //End  Dt:05/11/2019


            //Start Dt:22/11/2019
            $j('#Cb_IsITCAutoNoDisable').change(function () {
                if (this.checked) {
                    $j('#cb_IsIntChallanAutoNo').prop("checked", true);
                }
            });

            $j('#cb_IsIntChallanAutoNo').change(function () {
                if (!this.checked) {
                    $j('#Cb_IsITCAutoNoDisable').prop("checked", false);
                }
            });

            $j('#Cb_IsPRSAutoNoDisable').change(function () {
                if (this.checked) {
                    $j('#cb_IsPickupRunSheetAutoNo').prop("checked", true);
                }
            });

            $j('#cb_IsPickupRunSheetAutoNo').change(function () {
                if (!this.checked) {
                    $j('#Cb_IsPRSAutoNoDisable').prop("checked", false);
                }
            });

            $j('#Cb_IsHPAAutoNoDisable').change(function () {
                if (this.checked) {
                    $j('#cb_IsHpaAutoNo').prop("checked", true);
                }
            });

            $j('#cb_IsHpaAutoNo').change(function () {
                if (!this.checked) {
                    $j('#Cb_IsHPAAutoNoDisable').prop("checked", false);
                }
            });

            $j('#Cb_IsDRSAutoNoDisable').change(function () {
                if (this.checked) {
                    $j('#ch_IsDriverDeliveryAutoNo').prop("checked", true);
                }
            });

            $j('#ch_IsDriverDeliveryAutoNo').change(function () {
                if (!this.checked) {
                    $j('#Cb_IsDRSAutoNoDisable').prop("checked", false);
                }
            });
            //End Dt:22/11/2019

            //17/04/2020
            $j('#cb_IsRequiredModeofTransportation').change(function () {
                if (this.checked) {
                    $j('#cb_IsDisplayModeofTransportation').prop("checked", true);
                }
            });
            $j('#cb_IsDisplayModeofTransportation').change(function () {
                if (!this.checked) {
                    $j('#cb_IsRequiredModeofTransportation').prop("checked", false);
                }
            });


            $j('#cb_IsRequiredLoadType').change(function () {
                if (this.checked) {
                    $j('#cb_IsDisplayLoadType').prop("checked", true);
                }
            });
            $j('#cb_IsDisplayLoadType').change(function () {
                if (!this.checked) {
                    $j('#cb_IsRequiredLoadType').prop("checked", false);
                }
            });
            //17/04/2020


            $j('#cb_IsDisplayReverseChargeinBill').change(function () {
                ReverseChargeinBill();
            });
            ReverseChargeinBill();

            $j('#cb_IsRequiredMaterialType').change(function () {
                if (this.checked) {
                    $j('#cb_IsDisplayMaterialType').prop("checked", true);
                }
            });

            $j('#cb_IsDisplayMaterialType').change(function () {
                if (!this.checked) {
                    $j('#cb_IsRequiredMaterialType').prop("checked", false);
                }
            });

            $j('#cb_RemovePaidLrType').change(function () {
                RemovePaidLrType();
            });
            RemovePaidLrType();
        });

        function RemovePaidLrType() {
            if ($j('#cb_RemovePaidLrType').prop("checked")) {
                var LrType = $j("#dd_LrType option:selected").text();
                if (LrType == "PAID") {
                    $j('#dd_LrType').val("0");
                }
                $j("#dd_LrType option[value='3']").attr('disabled', 'disabled');
            }
            else {
                $j("#dd_LrType option[value='3']").removeAttr("disabled");
            }
        }

        function ReverseChargeinBill() {
            if ($j("#cb_IsDisplayReverseChargeinBill").prop("checked")) {
                $j("#dd_ReverseCharge").show();
            }
            else {
                $j("#dd_ReverseCharge").prop('selectedIndex', 0);
                $j("#dd_ReverseCharge").hide();
            }
        }

        function BindSMSAPIHostName() {

            if ($j("#ddl_SmsApiHostName").val() == "0") {
                $j("#tb_SMSAPIHostName").val("http://malerts.tfbs.in/sendsmsv2.asp?");
                document.getElementById('SMSKey').style.display = 'none';
                document.getElementById('SMSRoute').style.display = 'none';
            }
            else if ($j("#ddl_SmsApiHostName").val() == "1") {
                //$j("#tb_SMSAPIHostName").val("http://erp.aerosol.io/api/sendmsg.php?");
                $j("#tb_SMSAPIHostName").val("http://bhashsms.com/api/sendmsg.php?");
                document.getElementById('SMSKey').style.display = 'none';
                document.getElementById('SMSRoute').style.display = 'none';
            }
            else if ($j("#ddl_SmsApiHostName").val() == "2") { //spider
                $j("#tb_SMSAPIHostName").val("http://ui.netsms.co.in/API/SendSMS.aspx?");
                document.getElementById('SMSKey').style.display = 'block';
                document.getElementById('SMSRoute').style.display = 'none';
            }
            else if ($j("#ddl_SmsApiHostName").val() == "3") {//softsms
                $j("#tb_SMSAPIHostName").val("http://softsms.in/app/smsapi/index.php?");
                document.getElementById('SMSKey').style.display = 'block';
                document.getElementById('SMSRoute').style.display = 'none';
            }
            else if ($j("#ddl_SmsApiHostName").val() == "4") {//pnd
                $j("#tb_SMSAPIHostName").val("http://sms.pndsolutions.in/http-api.php?");
                document.getElementById('SMSKey').style.display = 'none';
                document.getElementById('SMSRoute').style.display = 'block';
            }
            else if ($j("#ddl_SmsApiHostName").val() == "5") {//SMS Service Portal
                $j("#tb_SMSAPIHostName").val("http://mobi1.blogdns.com/WebSMSS/SMSSenders.aspx?");
                document.getElementById('SMSKey').style.display = 'none';
                document.getElementById('SMSRoute').style.display = 'none';
            }
            else if ($j("#ddl_SmsApiHostName").val() == "6") {//Gateway Hub
                $j("#tb_SMSAPIHostName").val("https://www.smsgatewayhub.com/api/mt/SendSMS?");
                document.getElementById('SMSKey').style.display = 'block';
                document.getElementById('SMSRoute').style.display = 'block';
            }
            else if ($j("#ddl_SmsApiHostName").val() == "7") { //k3DigitalMedia
                $j("#tb_SMSAPIHostName").val("http://k3digitalmedia.co.in/websms/api/http/index.php?");
                document.getElementById('SMSKey').style.display = 'block';
                document.getElementById('SMSRoute').style.display = 'none';
            }
            else if ($j("#ddl_SmsApiHostName").val() == "8") { //vas.gsmash
                $j("#tb_SMSAPIHostName").val("http://vas.gsmash.com/api.php?");
                document.getElementById('SMSKey').style.display = 'none';
                document.getElementById('SMSRoute').style.display = 'none';
            }
            else if ($j("#ddl_SmsApiHostName").val() == "9") { //onlysms
                $j("#tb_SMSAPIHostName").val("https://onlysms.co.in/api/sms.aspx?");
                document.getElementById('SMSKey').style.display = 'none';
                document.getElementById('SMSRoute').style.display = 'none';
            }
            else if ($j("#ddl_SmsApiHostName").val() == "10") {//Telegram
                document.getElementById("tb_SMSAPIHostName").value = "https://emessage.aerosol.io/api/TelegramApi/SendMessageToNumber?";
                document.getElementById('SMSKey').style.display = 'none';
                document.getElementById('SMSRoute').style.display = 'none';
            }
        }
        function Numericdotonly(event, id) {
            var Key = (event.keyCode ? event.keyCode : event.which);
            if (Key != 9 && Key != 8 && Key != 46 && (Key < 48
                || Key > 57)) {
                event.preventDefault();
                return false;
            }
            var character = document.getElementById(id).value;
            if (Key == 46 && character.indexOf('.') != -1) {
                return false;
            }
            return true;
        }
        function IsLrNoDisable(val) {
            if (val) {
                document.getElementById("dv_LrDisable").style.display = 'block';
            }
            else {
                document.getElementById("cb_IsLrAutoNoDisable").checked = false;
                document.getElementById("dv_LrDisable").style.display = 'none'; //.display = 'none';
            }
        }
        function IsChlNoDisable(val) {
            if (val) {
                document.getElementById("dv_IsChallanDisable").style.display = 'block';
            }
            else {
                document.getElementById("cb_IsChNoDisable").checked = false;
                document.getElementById("dv_IsChallanDisable").style.display = 'none'; //.display = 'none';
            }
        }

        function IsCrossingMemoDisable(val) {
            if (val) {
                document.getElementById("dv_IsCrossingDisable").style.display = 'block';
            }
            else {
                document.getElementById("cb_IsCrossingNoDisable").checked = false;
                document.getElementById("dv_IsCrossingDisable").style.display = 'none'; //.display = 'none';
            }
        }
        function IsDisableMrNo(val) {
            if (val) {
                document.getElementById("dv_IsDisableMrNo").style.display = 'block';
            }
            else {
                document.getElementById("cb_IsDisableMrNo").checked = false;
                document.getElementById("dv_IsDisableMrNo").style.display = 'none'; //.display = 'none';
            }
        }

        //function IsLrNoUniqueInSystem(val) {
        //    if (val) {
        //        document.getElementById("dv_IsLrNoUnique").style.display = 'block';
        //        document.getElementById("dv_LrAutoCompanyWise").style.display = 'block';
        //    }
        //    else {
        //        document.getElementById("dv_IsLrNoUnique").style.display = 'none'; //.display = 'none';
        //        document.getElementById("dv_LrAutoCompanyWise").style.display = 'none';
        //    }
        //}

        function IsAddBillOnPaymentMode(val, id) {

            if (val == true && id == 'cb_PaymentModeWithBillOn') {
                $j("#rbl_IsCash_3").show();
                $j("#rbl_IsCash_3").next().show();
            }
            else if (val == false && id == 'cb_PaymentModeWithBillOn') {
                $j("#rbl_IsCash_3").hide();
                $j("#rbl_IsCash_3").next().hide();
            }

            if (val == true && id == 'cb_IsDisplayCreditInDeliveryPaid') {
                $j("#rbl_IsCash_2").show();
                $j("#rbl_IsCash_2").next().show();
            }
            else if (val == false && id == 'cb_IsDisplayCreditInDeliveryPaid') {
                $j("#rbl_IsCash_2").hide();
                $j("#rbl_IsCash_2").next().hide();
            }
        }

        function isPaymentModeWithBillOn() {
            if ($j("#cb_PaymentModeWithBillOn").is(":checked")) {
                $j("#rbl_IsCash_3").show();
                $j("#rbl_IsCash_3").next().show();
            }
            else {
                $j("#rbl_IsCash_3").hide();
                $j("#rbl_IsCash_3").next().hide();
            }

            if ($j("#cb_IsDisplayCreditInDeliveryPaid").is(":checked")) {
                $j("#rbl_IsCash_2").show();
                $j("#rbl_IsCash_2").next().show();
            }
            else {
                $j("#rbl_IsCash_2").hide();
                $j("#rbl_IsCash_2").next().hide();
            }
        }

        function ShowFreightTOPay() {
            var ctrl = document.getElementById('cb_IsMinimumFreight');
            if (ctrl.checked) {
                document.getElementById("tb_MinimumFreight").style.display = 'block';
            }
            else {
                document.getElementById("tb_MinimumFreight").style.display = 'none'; //.display = 'none';
            }
        }
        function ShowFreightTBB() {
            var ctrl = document.getElementById('cb_IsMaximumFreight');
            if (ctrl.checked) {
                document.getElementById("tb_MaximumFreight").style.display = 'block';
            }
            else {
                document.getElementById("tb_MaximumFreight").style.display = 'none'; //.display = 'none';
            }
        }


        //function functionForpercentage(sender, args) {
        //    var maxKPIPercentage = 100;
        //    var totalKPIPercentage = 0;
        //    totalKPIPercentage = $j("#tb_LessDeductionPer").val();

        //    if (parseFloat(totalKPIPercentage) > parseFloat(maxKPIPercentage)) {
        //        alert("Percentage Exceeded");
        //    }
        //    event.stopPropagation();
        //}
        function DisplayFreightAt() {

            if ($j("#ch_IsAutoSelectedFrtAt").is(":checked")) {
                //ddl_FreightAtBranch
                $j("#ddl_FreightAtBranch").show('slow');
            }
            else {
                $j("#ddl_FreightAtBranch").hide('slow');
            }
            $j('#ch_IsAutoSelectedFrtAt').live('click', function () {
                if ($j('#ch_IsAutoSelectedFrtAt').is(':checked')) {
                    $j("#ddl_FreightAtBranch").show();
                } else {
                    $j("#ddl_FreightAtBranch").hide();
                }
            });
        }

        function IsDisplayDDMDays(val) {
            try {
                if (val) {
                    $j("#tb_DDMDays").fadeIn(500);
                }
                else {
                    $j("#tb_DDMDays").fadeOut();
                }
            } catch (e) {
                alert(e);
            }
        }

        function DisplayCashPaymentLimit() {

            if ($j("#cb_CashPaymentLimit").is(":checked")) {
                $j("#tb_CashPaymentLimit").show('slow');
            }
            else {
                $j("#tb_CashPaymentLimit").hide('slow');
            }
            $j('#cb_CashPaymentLimit').live('click', function () {
                if ($j('#cb_CashPaymentLimit').is(':checked')) {
                    $j("#tb_CashPaymentLimit").show();
                } else {
                    $j("#tb_CashPaymentLimit").hide();
                }
            });
        }

        function DisplayLockBasedOnDays() {

            if ($j("#cb_LockBasedOnDays").is(":checked")) {
                $j("#tb_LockBasedOnDays").show('slow');
            }
            else {
                $j("#tb_LockBasedOnDays").hide('slow');
            }
            $j('#cb_LockBasedOnDays').live('click', function () {
                if ($j('#cb_LockBasedOnDays').is(':checked')) {
                    $j("#tb_LockBasedOnDays").show();
                } else {
                    $j("#tb_LockBasedOnDays").hide();
                }
            });
        }

        function DisplayOrderExpectedDateBasedOnTransistDays() {

            if ($j("#cb_IsDisplayOrderExpectedDate").is(":checked")) {
                $j("#tb_OrderTransistDays").show('slow');
            }
            else {
                $j("#tb_OrderTransistDays").hide('slow');
            }
            $j('#cb_IsDisplayOrderExpectedDate').live('click', function () {
                if ($j('#cb_IsDisplayOrderExpectedDate').is(':checked')) {
                    $j("#tb_OrderTransistDays").show();
                } else {
                    $j("#tb_OrderTransistDays").hide();
                }
            });
        }

        function Numericonly(event, id) {
            //alert(event.keyCode);

            var Key = (event.keyCode ? event.keyCode : event.which);
            //alert(Key);

            if (Key != 9 && Key != 8 && Key != 46 && (Key < 48
                || Key > 57)) {
                event.preventDefault();
                return false;
            } // prevent if not number/dot

            if (Key == 46) {
                return false;

            }
            // prevent if already dot

            return true;

        }

        $(document).ready(function () {
            $("#tb_BeforeTime").mask('99:99');
            $("#tb_Timedifference").mask('99:99');
        });


    </script>

    <style type="text/css">
        fieldset {
            border: 0;
        }

            fieldset.display {
                border: 1px solid #cccccc;
            }

        .width60per {
            width: 60%;
        }

        .width25per {
            width: 25%;
        }

        .width50per {
            width: 50%;
        }

        .width40per {
            float: right;
            width: 40%;
        }
    </style>
</head>
<body>
    <div>
        <form id="frm_AddDieselQty" runat="server">
            <div id="page" class="hide">
                <div id="header">
                    <div class="">
                        <%--<%=Utility.TitleText.ToString() %>--%>
                    </div>
                    <a href="#menu"></a>
                </div>
                <nav id="menu">
			    <uc3:LeftMobile ID="LeftMobile1" runat="server" />
			</nav>
            </div>
            <div class="main">
                <div id="top_hdr">
                    <uc1:Header ID="Header1" runat="server" />
                </div>
                <div class="middle">
                    <div id="left">
                        <uc2:Left ID="Left1" runat="server" />
                    </div>
                    <div class="right_part">
                        <div class="top_ttl">
                            <div class="titl">
                                <div class="ttl_icon">
                                    <img src="images/IconWhite/settings.png" alt="" width="40" height="32" />
                                </div>
                                <div class="ttl_txt">
                                    Settings&nbsp;&nbsp;&nbsp;<asp:Label ID="l_Error" runat="server" ForeColor="red"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="create_main">
                            <div class="inner_crt">
                                <div class="form_left">
                                    <div runat="server" class="form_grid">
                                        <div class="form_lab">
                                            Allow OTP for Password:
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" ID="cb_IsAuthorisedPassword" CssClass="fill" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Allow SMS For Bilty Entry:
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" CssClass="fill" ID="cb_IsSms" />
                                        </div>
                                    </div>
                                    <div class="form_grid" runat="server">
                                        <div class="form_lab">
                                            Mobile No:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_MobileNo" runat="server" CssClass="fill" MaxLength="100" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none;">
                                        <div class="form_lab">
                                            Send Daily SMS Report Mobile No:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_AdminMobile" runat="server" CssClass="fill" MaxLength="100" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none;">
                                        <div class="form_lab">
                                            Allow Weight:
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" CssClass="fill" ID="cb_IsWeight" />
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none;">
                                        <div class="form_lab">
                                            TIN No:<span class="mndt">*</span>
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_TINNo" runat="server" CssClass="fill" MaxLength="20" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none;">
                                        <div class="form_lab">
                                            TIN Date:<span class="mndt">*</span>
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_TINDate" runat="server" CssClass="fill" MaxLength="20" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none;">
                                        <div class="form_lab">
                                            Phone:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_Phone" runat="server" CssClass="fill" MaxLength="20" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none;">
                                        <div class="form_lab">
                                            Retailer Pre-fix:<span class="mndt">*</span>
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_WithoutTINNo" runat="server" CssClass="fill" MaxLength="20" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none;">
                                        <div class="form_lab">
                                            Tax Pre-fix:<span class="mndt">*</span>
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_WithTIN" runat="server" CssClass="fill" MaxLength="20" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none;">
                                        <div class="form_lab">
                                            Cash Pre-fix:<span class="mndt">*</span>
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_Cash" runat="server" CssClass="fill" MaxLength="20" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none;">
                                        <div class="form_lab">
                                            CST No.:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_CSTNo" runat="server" CssClass="fill" MaxLength="20" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none;">
                                        <div class="form_lab">
                                            CST Date:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_CSTDate" runat="server" CssClass="fill" MaxLength="20" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Vehicle Reminder Day:<span class="mndt">*</span>
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_VehicleReminderHour" runat="server" CssClass="fill" MaxLength="20"
                                                Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Allow SMS For Payment
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox ID="chk_SmsForPayment" CssClass="fill" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Allow SMS For Receipt:
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox ID="chk_SmsForReceipt" CssClass="fill" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Allow SMS For Receipt Confirmation:
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox ID="cb_SMSReceiptConfirmation" CssClass="fill" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Less Abatement:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_Abatement" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                MaxLength="10" Font-Size="Small"></asp:TextBox>
                                            %
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Chargeable Freight:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_CFreight" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                MaxLength="10" Font-Size="Small"></asp:TextBox>
                                            %
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Service Tax:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_ServiceTax" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                MaxLength="10" Font-Size="Small"></asp:TextBox>
                                            %
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Costing Report Email Id For Less Then Zero:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_EmailCostingLessThanZero" onblur="validateMultipleEmailsCommaSeparated(this,',');"
                                                runat="server" CssClass="fill_txt" TextMode="MultiLine" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            <br />
                                            ex: xyz@XXX.com,xyz@xxx.in
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Costing Report Email Id For Equal To Zero:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_EmailCostingEqualToZero" onblur="validateMultipleEmailsCommaSeparated(this,',');"
                                                runat="server" CssClass="fill_txt" TextMode="MultiLine" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            <br />
                                            ex: xyz@XXX.com,xyz@xxx.in
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Costing Report Email Id For 3 % Of Margin:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_EmailCostingThreePer" onblur="validateMultipleEmailsCommaSeparated(this,',');"
                                                runat="server" CssClass="fill_txt" TextMode="MultiLine" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            <br />
                                            ex: xyz@XXX.com,xyz@xxx.in
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Delete Data Email Id:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_DeleteDataEmailId" onblur="validateMultipleEmailsCommaSeparated(this,',');"
                                                runat="server" CssClass="fill_txt" TextMode="MultiLine" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            <br />
                                            ex: xyz@XXX.com,xyz@xxx.in
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Late LR Delivery Report Email Id:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_LateLRDeliveryEmail" onblur="validateMultipleEmailsCommaSeparated(this,',');"
                                                runat="server" CssClass="fill_txt" TextMode="MultiLine" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            ex: xyz@XXX.com,xyz@xxx.in
                                        </div>
                                    </div>

                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Daily Delivery Summary Email Id:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_DailyDeliverySummaryEmailIds" onblur="validateMultipleEmailsCommaSeparated(this,',');"
                                                runat="server" CssClass="fill_txt" TextMode="MultiLine" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            <br />
                                            ex: xyz@XXX.com,xyz@xxx.in
                                        </div>
                                    </div>

                                    <div class="form_grid" runat="server" visible="false">
                                        <div class="form_lab">
                                            User Limit Days For Transport Group:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_UserLimitDays" runat="server" CssClass="fill" MaxLength="3" Font-Size="Small"
                                                onkeypress="return Numeric(event);"></asp:TextBox>
                                        </div>
                                    </div>
                                    <%-- Dt:22/11/2019   <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_IsDriverDeliveryAutoNo"
                                                Text=" Is Driver Delivery Auto No." />
                                        </div>
                                    </div>--%>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_IsChequeprintEnablefromChequebook"
                                                Text=" Is Cheque Print Enable From Chequebook" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_IsLabourcontractAutoNo"
                                                Text=" Is Labour Contract Auto No." />
                                        </div>
                                    </div>
                                    <div runat="server" id="div_Royalty" style="float: right; margin-right: 50px; display: none">
                                        <div class="form_grid" style="display: none">
                                            <div class="form_lab">
                                                Royalty URL :<span class="mndt">*</span>
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_RoyaltyURL" CssClass="textfild-1" runat="server" MaxLength="150"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid" style="display: none">
                                            <div class="form_lab">
                                                Royalty Username :<span class="mndt">*</span>
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_RoyaltyUname" CssClass="textfild-1" runat="server" MaxLength="150"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid" style="display: none">
                                            <div class="form_lab">
                                                Royaly Password :<span class="mndt">*</span>
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_RoyaltyPwd" CssClass="textfild-1" runat="server" MaxLength="150"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsOrderMgmtAutoNo"
                                                Text=" Is Order Mgmt Auto No." />
                                        </div>
                                    </div>
                                    <%-- Dt:22/11/2019 <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsPickupRunSheetAutoNo"
                                                Text=" Is Pickup Run Sheet Auto No." />
                                        </div>
                                    </div>--%>

                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DoNotAllowFutureEntryTransG"
                                                Text=" Do Not Allow Future Entry in Transport Group/Accounting Group ?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DonotAllowFutureEntryInChequeBook"
                                                Text=" Do Not Allow Future Entry in Cheque Book ?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispCollectionChrgInBookingAgent"
                                                Text="Is Display Collection Charge in Booking Wise Agent ?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_ConsigneeConsignorMasterIsRequiredGSTNo"
                                                Text=" Is Required GST No. in ConsignorConsignee Master ?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsMobileNoUniqueInConsigneeMaster"
                                                Text=" Is Mobile No. Unique in Consignor / Consignee Master ?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispAmntUserinLRInquiry"
                                                Text=" Is Display Amount to User in LR Inquiry Report?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAllowSameConsigneeGST"
                                                Text=" Is Allow same GST No For Consignor/Consignee Master?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayAllBillInCashChequeJV"
                                                Text=" Is Display All Bill In Cash,Cheque, and Journal Voucher?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAllBranchRightsToAccMaster"
                                                Text=" Is All Branch Rights in Account Master(Party)?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_CashPaymentLimit"
                                                Text=" Is Set Cash Payment Limit" Width="65%" />
                                            <asp:TextBox ID="tb_CashPaymentLimit" runat="server" CssClass="fill width18per" Width="25%"
                                                Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_CashPaymentLimitForOther"
                                                Text=" Is Set Cash Payment Limit For Other" Width="65%" />
                                            <asp:TextBox ID="tb_CashPaymentLimitForOther" runat="server" CssClass="fill width18per" Width="25%"
                                                Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayClosingBalInCshChequePrint"
                                                Text=" Is Display Closing Balance in Cash/Cheque Print " />

                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SendMailToConsignorBillonForLRTrakingEntry"
                                                Text=" Send Mail To Consignor/Consignee/BillOn For LR Tracking Entry " />
                                        </div>
                                    </div>

                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisSearchInJVForLorryHirePayble"
                                                Text=" Is Display Search in JV for Lorry Hire Payable." />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDieselAutoReferenceEntry"
                                                Text=" Is Diesel Auto Reference Entry (Pickup/Internal/Challan/HPA/LocalDriver)" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Attendance Per Maximum Hours: 
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_Timedifference" runat="server" CssClass="fill" MaxLength="32" Text="0"
                                                Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Attendance Before Limit:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_BeforeTime" runat="server" CssClass="fill" MaxLength="32" Text="0"
                                                Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsCreateLedgerInBrokerMaster" Text=" Is Create Ledger In Broker Master." />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_ConsigneedependonCreditLimit" Text=" Is Consignee depend on Credit Limit.(Bilty Entry)" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_ConsigneedependonCreditLimitDP" Text=" Is Consignee depend on Credit Limit.(Delivery Paid)" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_ConsigneedependonCreditLimitDRS" Text=" Is Consignee depend on Credit Limit.(Local Driver Delivery)" />
                                        </div>
                                    </div>

                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisManagerApprovedEntryInReport" Text=" Is Cash Book Base on Approval ?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredConsigneePincode" Text=" Is Required Pincode in Consignor/Consignee Master?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsCreateOwnerInBrokerMaster" Text=" Is Create Owner In Broker Master." />
                                        </div>
                                    </div>

                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredUnloadingLabourInRecConf" Text=" Is Required Unloading Labour In Receipt Confirmation ?" />
                                        </div>
                                    </div>

                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_AllowChangeChequebookAfterReco" Text=" Allow to Change in Chequebook Entry after Reconsilation ?" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form_right">
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            SMS API Host:<span class="mndt">*</span>
                                        </div>
                                        <div class="form_fill">
                                            <asp:DropDownList ID="ddl_SmsApiHostName" runat="server" CssClass="fill">
                                                <asp:ListItem Value="0">malerts</asp:ListItem>
                                                <asp:ListItem Value="1">bhashsms</asp:ListItem>
                                                <asp:ListItem Value="2">Spider</asp:ListItem>
                                                <asp:ListItem Value="3">SoftSMS</asp:ListItem>
                                                <asp:ListItem Value="4">PndSolutions</asp:ListItem>
                                                <asp:ListItem Value="5">SMS Service Portal</asp:ListItem>
                                                <asp:ListItem Value="6">Gateway Hub</asp:ListItem>
                                                <asp:ListItem Value="7">K3 Digital Media</asp:ListItem>
                                                <asp:ListItem Value="8">vas.gsmash</asp:ListItem>
                                                <asp:ListItem Value="9">onlysms</asp:ListItem>
                                                <asp:ListItem Value="10">Telegram</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab_height10px">
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_SMSAPIHostName" runat="server" CssClass="fill" MaxLength="90"
                                                Font-Size="Small" onkeypress="return AllowAlphabet(event);"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="form_grid">
                                        <div class="form_lab">
                                            SMS API UserName:<span class="mndt">*</span>
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_SMSUsername" runat="server" CssClass="fill" MaxLength="150" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            SMS API Password:<span class="mndt">*</span>
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_SMSPassword" runat="server" CssClass="fill" MaxLength="20" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            SMS Sender:<span class="mndt">*</span>
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_SMSSender" runat="server" CssClass="fill" MaxLength="20" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none;" id="SMSKey" runat="server">
                                        <div class="form_lab">
                                            SMS API Key:<span class="mndt">*</span>
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_SMSAPIKey" runat="server" CssClass="fill" MaxLength="50" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none;" id="SMSRoute" runat="server">
                                        <div class="form_lab">
                                            SMS Route:<span class="mndt">*</span>
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_SMSRoute" runat="server" CssClass="fill" MaxLength="50" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="form_grid" style="display: none;">
                                        <div class="form_lab">
                                            Login SMS No.:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_SMSLoginNo" runat="server" CssClass="fill" MaxLength="20" Font-Size="Small"></asp:TextBox>
                                        </div>
                                    </div>



                                    <div class="form_grid">
                                        <div class="form_lab">
                                            SB Cess:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_Education" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                MaxLength="10" Font-Size="Small"></asp:TextBox>
                                            %
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            H.Ean:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_HEan" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                MaxLength="10" Font-Size="Small"></asp:TextBox>
                                            %
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            KK Cess:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_KkCess" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                MaxLength="10" Font-Size="Small"></asp:TextBox>
                                            %
                                        </div>
                                    </div>

                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Bill Not Created For Bilty More Than Month Email Id:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_EmailBillNotCreated" onblur="validateMultipleEmailsCommaSeparated(this,',');"
                                                CssClass="fill_txt" TextMode="MultiLine" runat="server" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            <br />
                                            ex: xyz@XXX.com,xyz@xxx.in
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Bill Outstanding Email Id:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_EmailBillOutStanding" onblur="validateMultipleEmailsCommaSeparated(this,',');"
                                                CssClass="fill_txt" TextMode="MultiLine" runat="server" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            <br />
                                            ex: xyz@XXX.com,xyz@xxx.in
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            P & L / Trail Balance / Cash Flow Email Id:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_EmailTrailBalance" onblur="validateMultipleEmailsCommaSeparated(this,',');"
                                                CssClass="fill_txt" TextMode="MultiLine" runat="server" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            <br />
                                            ex: xyz@XXX.com,xyz@xxx.in
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Reminder Report Email Id:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_ReminderEmailId" onblur="validateMultipleEmailsCommaSeparated(this,',');"
                                                runat="server" CssClass="fill_txt" TextMode="MultiLine" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            <br />
                                            ex: xyz@XXX.com,xyz@xxx.in
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Late Booking Report Email Id:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_LateBookingEmail" onblur="validateMultipleEmailsCommaSeparated(this,',');"
                                                runat="server" CssClass="fill_txt" TextMode="MultiLine" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            <br />
                                            ex: xyz@XXX.com,xyz@xxx.in
                                        </div>
                                    </div>

                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Daily Booking Summary Email Id:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_DailyBookingSummaryEmailIds" onblur="validateMultipleEmailsCommaSeparated(this,',');"
                                                runat="server" CssClass="fill_txt" TextMode="MultiLine" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            <br />
                                            ex: xyz@XXX.com,xyz@xxx.in
                                        </div>
                                    </div>



                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Text=" Is Laser Printer" Font-Bold="true" CssClass="fill" ID="cb_TicketPrinter" />
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none">
                                        <div class="form_lab">
                                            Display Carting in Print:
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" ID="cb_DisplayCartingAgent" />
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none">
                                        <div class="form_lab">
                                            Display Cust. Address in Sale Print:
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" ID="cb_DisplayAddress" />
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none">
                                        <div class="form_lab">
                                            Allow Consignment :
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox ID="chk_ConsignmentNote" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none;">
                                        <div class="form_lab">
                                            Allow e-Royalty For ATR :
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox ID="chk_RoyaltyForATR" CssClass="fill" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form_grid" style="display: none;">
                                        <div class="form_lab">
                                            Allow e-Royalty :
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox ID="chk_Royalty" onclick="DisplayRoyaltyDetaildiv(this.checked);" runat="server" />
                                        </div>
                                    </div>

                                    <div class="form_grid" runat="server" visible="false">
                                        <div class="form_lab">
                                            User Limit Days For Accounting Group:
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_UserLimitForAcGroup" runat="server" CssClass="fill" MaxLength="3"
                                                Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_IsEmpPaymentMonthly"
                                                Text=" Is Employee Payment Monthly" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsGlobalDataInReport"
                                                Text=" Is Global Data Display In Report" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsMRNoDisplayInCashBook"
                                                Text=" Is Manual MR No Display In CashBook" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_NotDispConsigneeMobNo"
                                                Text=" Not Show Mobile No. In  Consignee/Consignor Master" />
                                        </div>
                                    </div>

                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendMailOnShortagePkg"
                                                Text=" Is Send Package Shortage Mail From Receipt Confirmation ?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendMailPickUpRunSheet"
                                                Text=" Is Send Mail On Create Pickup Run Sheet ?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredPanInBrokerMaster"
                                                Text=" Is Required Pan No. in Broker Master ?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredMobileNoInBrokerMaster"
                                                Text=" Is Required Mobile No. in Broker Master ?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsUniqueBrokerName"
                                                Text=" Is Unique Broker Name in Broker Master ?" />
                                        </div>
                                    </div>

                                    <%-- Added On 19/06/2017 By Vijay Dabhi END --%>

                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredGSTNo"
                                                Text=" Is Required GST No. in Account Master?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispTruckNoUserinLRInquiry"
                                                Text=" Is Display Truck No to User in LR Inquiry Report?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsVoucherNoEditable"
                                                Text=" Is Voucher No Editable In Cash\Cheque\Contra\JV Entry?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredConsigneeState"
                                                Text=" Is Required State in Consignor/Consignee Master?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredConsigneeCity"
                                                Text=" Is Required City in Consignor/Consignee Master?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredConsigneeAddress"
                                                Text=" Is Required Address in Consignor/Consignee Master?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAllBranchRightsToConsignee"
                                                Text=" Is All Branch Rights in Consignor/Consignee Master?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsNotAllowNegativeCashPayment"
                                                Text=" Is Not Allow Negative Entry in Cash Payment?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:Label runat="server" Font-Bold="true" CssClass="fill" ID="l_DaysForNEFT"
                                                Text=" Days Limit For NEFT ENTRY" Width="55%" />
                                            <asp:TextBox ID="tb_LockForDaysforNEFT" runat="server" CssClass="fill width18per" Width="35%"
                                                Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsCompulsuryEmailIdConsigneeConsignor"
                                                Text=" Is Compulsury Email Id in Consignee-Consingor Master?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsLockForEwayBillInLRTrackingEntry"
                                                Text=" Is Lock For E-WayBill In LR Tracking Entry " />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                            Bal.Pay At For Pickup/Internal Challan Entry,Challan Entry,HPA,DRS
                                        </div>
                                        <div class="form_fill dvOverFlow dvBorder" style="width: 100%; height: 125px">
                                            <asp:CheckBoxList ID="cbl_BalPayAtDefault" TabIndex="-1" Style="width: auto;" RepeatLayout="Table" RepeatColumns="3"
                                                RepeatDirection="Horizontal" runat="server" CssClass="chkList">
                                            </asp:CheckBoxList>
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAllowTDSRoundOffForAll"
                                                Text=" Is Allow TDS Round Off for Pickup/Internal/Challan/HPA/DRS/Broker Payment & Purchase Voucher?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayPreviousYearLRtoUser"
                                                Text=" Is Display Previous Year LR to User(LR Inquiry Report)" />
                                        </div>
                                    </div>
                                    <%--04/04/2020--%>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsBillOnDependOnCreditLimit" Text=" Is Bill On depend on Credit Limit.(Bilty Entry)" />
                                        </div>
                                    </div>
                                    <%--04/04/2020--%>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsBillOnDependOnCreditLimitDRS" Text=" Is Bill On depend on Credit Limit.(Local Driver Delivery)" />
                                        </div>
                                    </div>

                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredVehicleNoFormatValidation" Text=" Is Required Vehicle No Format Validation ?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsTripsheetExistNotEditAnyEntry" Text=" Is Tripsheet Entry Exist do Not Edit Bilty/Pickup/Internal/Challan/Crossing and DRS Entry ?" />
                                        </div>
                                    </div>
                                    <div class="form_grid">
                                        <div class="form_lab">
                                        </div>
                                        <div class="form_fill">
                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredChequeNoInChequeBookEntryReceiptVoucher" Text=" Is Required Cheque No In Cheque Book Entry - Receipt Voucher" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Delivery Paid Setting
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" onclick="IsDisableMrNo(this.checked);" ID="ch_IsDeliveryPaidAuto"
                                                    Text=" Is Delivery Paid Mr Auto No." />
                                            </div>
                                        </div>
                                        <div class="form_grid" runat="server" id="dv_IsDisableMrNo" style="display: none">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisableMrNo"
                                                    Text=" Is Mr Auto No Disable" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRecConBase"
                                                    Text=" Is Receipt Con. Base LR" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDeliveryPaidWithLRWiseCharges"
                                                    Text=" Is Delivery Paid With LR Wise Charges" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayOtherChargeDel"
                                                    Text=" Is Display Other Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayOctroiServ"
                                                    Text=" Is Display Octroi Serv. ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayDemrage"
                                                    Text=" Is Display Demrage ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:Label ID="l_DefaultLrT" runat="server" Font-Bold="true" Text="Default LR Show In Grid" CssClass="fill width71box"></asp:Label>
                                                <asp:TextBox ID="tb_DefaultGridRowDPaid" runat="server" CssClass="fill width18per" MaxLength="3"
                                                    Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisplayPartyBank"
                                                    Text=" Is Display Party Bank In Delivery Paid" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequirePartyBank"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayTotalWeight"
                                                    Text=" Is Display Total Weight?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:Label ID="Label1" runat="server" Font-Bold="true" Text="Less Deduction Percentage for Report" CssClass="fill width71box"></asp:Label>
                                                <asp:TextBox ID="tb_LessDeductionPer" runat="server" CssClass="fill width18per" MaxLength="2"
                                                    Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsLrBaseOnBarcode"
                                                    Text=" Is LR Entry Base on Barcode In Delivery Paid?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_IsSendDeliveryAlertMailtoConsignee"
                                                    Text=" Is Send Delivery Alert Mail to Consignee?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayGInsuranceChg"
                                                    Text=" Is Display GInsurance Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCESSTax"
                                                    Text=" Is Display CESS Tax ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_AllowEditConsignee"
                                                    Text=" Is Consignee Name Editable for User Without Edit ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoFillLRPrivateMarkInRemark"
                                                    Text=" Autofill LR Single Private Mark in Remark ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsReqDeliveryPersoninDeliveryPaid"
                                                    Text=" Is Required Delivery Person in Delivery Paid ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsAutoCcDueInDPP"
                                                    Text=" Is Cc Due Auto Entry In Delivery Paid Payment?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayWeightmentCharges"
                                                    Text=" Is Display Weightment Charges?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsNotDisplayTDSinDeliveryPaid"
                                                    Text=" Is Not Display TDS in Delivery Paid?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_LockBasedOnDays"
                                                    Text=" Lock Based On Days" Width="65%" />
                                                <asp:TextBox ID="tb_LockBasedOnDays" runat="server" CssClass="fill width18per" Width="25%"
                                                    Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAllowDeliveryPaidUpdateForAdmin"
                                                    Text=" Is Allow Delivery Paid in Cash/Bank Update To Admin?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsUpdateGodownNameInDailyDeliveryReport"
                                                    Text=" Is Update Godown Name In Daily Delivery Report?" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_right">

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" onclick="IsAddBillOnPaymentMode(this.checked,this.id);" CssClass="fill" ID="cb_IsDisplayCashInDeliveryPaid"
                                                    Width="40%" Text=" Is Display Cash ?" />
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill b_float margin2per" ID="cb_IsDisplayBankInDeliveryPaid" onclick="IsAddBillOnPaymentMode(this.checked,this.id);"
                                                    Text=" Is Display Bank ?" Width="40%" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" onclick="IsAddBillOnPaymentMode(this.checked,this.id);" CssClass="fill" ID="cb_PaymentModeWithBillOn"
                                                    Width="50%" Text=" Is Payment Mode With Bill On?" />
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill b_float margin2per" ID="cb_IsDisplayCreditInDeliveryPaid" onclick="IsAddBillOnPaymentMode(this.checked,this.id);"
                                                    Text=" Is Display Credit ?" Width="35%" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Payment Mode
                                            </div>
                                            <div class="form_fill">
                                                <asp:RadioButtonList CssClass="blt_fill" RepeatDirection="Horizontal"
                                                    Width="100%" ID="rbl_IsCash" runat="server">
                                                    <asp:ListItem Text=" Cash" Selected="True" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text=" Bank" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text=" Credit" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text=" Bill On" Value="4"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_Del_IsLrpaidTotalInclude"
                                                    Text=" Is Delivery Paid Lr Paid Total Include In freight" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:Label ID="l_delroundtext" runat="server" Font-Bold="true" CssClass="fill width73box" Text="Round Off Charge In Delivery Paid"></asp:Label>
                                                <asp:DropDownList ID="dd_DelRoundOffCharge" runat="server" TabIndex="22"
                                                    CssClass="fill width20per">
                                                    <asp:ListItem Text="-1" Value="-1"></asp:ListItem>
                                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>

                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsCcDue"
                                                    Text=" Is Display Cc Due In Form" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayDoorDelivery"
                                                    Text=" Is Display Door Delivery ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayHamaliDel"
                                                    Text=" Is Display Hamali ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayDocateCharge"
                                                    Text=" Is Display Service Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsApplyServiceTax"
                                                    Text=" Is Service Tax Also Apply In Delivery Paid ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayFolioNo"
                                                    Text=" Is Display Folio No?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsPartialDelivery"
                                                    Text=" Is Display Partial Delivery?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayReceiver"
                                                    Text=" Is Display Receiver?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsReqReceiverNameinDeliveryPaid"
                                                    Text=" Is Required Receiver Name in Delivery Paid ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayMRNo2"
                                                    Text=" Is Display MR No. 2 ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayPollutionChg"
                                                    Text=" Is Display Pollution Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_sendSMSDelivery"
                                                    Text=" Allow Delivery SMS ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispSecondDedChrgInDpp"
                                                    Text=" Is Display 2nd Deduction Charge in Delivery Paid Payment?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsAutoDeduction"
                                                    Text=" Is Auto Deduction In Delivery Paid Payment?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoFillDeliveryPersonInDelPaid"
                                                    Text=" Is Auto Fill Delivery Person In Delivery Paid ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsShortcutforMRinDeliveryPaidPayment"
                                                    Text=" Is Require Shortcut for MR in Delivery Paid Payment ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayMarketingCharge"
                                                    Text=" Is Display Marketing Charges?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSequenceMaintainDeliveryDateBase"
                                                    Text=" Is Sequence Maintain Delivery Date Base ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisableDeliveryPaidPaymentAutoNo"
                                                    Text=" Is Delivery Paid Payment Auto No Disable ?" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Bilty Setting
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_IsBiltyAutoNo"
                                                    Text=" Is Bilty Lr Auto No. (Unique Branch Wise)" onclick="IsLrNoDisable(this.checked);" ToolTip="LR No. is auto fill base on manage chalan no. and Lr no is unique branch wise." />
                                            </div>
                                        </div>
                                        <div class="form_grid" id="dv_LrDisable" runat="server">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsLrAutoNoDisable" Width="48%"
                                                    Text=" Is Bilty Lr Auto No Disable" ToolTip="Do Not Allow Manually Bilty Entry on tick" />
                                                <a href='javascript:OpenBranchList();' style="cursor: pointer; text-decoration: underline; margin-left: 10px;">Auto No Disable Branch Wise</a>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsLrNoSeriesWise"
                                                    Text=" Is Bilty Lr No. Series Wise" ToolTip="LR No. Based on From And To Number in Manage Chalan no." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <%--<asp:CheckBox runat="server" Font-Bold="true" onclick="IsLrNoUniqueInSystem(this.checked);" CssClass="fill" ID="ch_IsLrNoUniqueCompanywise"
                                                    Text=" Is LR No Unique Company Wise (Financial Year)" ToolTip="LR no. is unique financial year and company wise for all branches" />--%>
                                                <asp:DropDownList runat="server" ID="dd_LrNoWise" class="fill" Width="100%">
                                                    <asp:ListItem Value="0" Selected="True">Unique Branch Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="1"> Is LR No Unique Company Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="2"> Is LR No. Unique In System </asp:ListItem>
                                                    <asp:ListItem Value="3"> Is LR No. Unique Branch Wise </asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid" id="dv_LrAutoCompanyWise" runat="server">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" Width="265px" CssClass="fill margin2per" ID="cb_LrAutoCompanyWise"
                                                    Text=" Is LR No. company wise as per entered no." ToolTip="LR no is unique in system not financial year and branch wise as per enter value" />
                                                <asp:TextBox runat="server" onkeypress="return Numericonly(event,this.id);" placeholder="Auto Generate LR No." ID="tb_LrAutoCompanyWise" Width="65px" MaxLength="7" CssClass="fill"></asp:TextBox>
                                            </div>
                                        </div>

                                        <%--Dt : 13/08/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsLrAutoNoStockWise"
                                                    Text=" Is Bilty Lr No. Inventory Stock Wise" ToolTip="LR No. Based on Inventory Stock Wise." />
                                            </div>
                                        </div>
                                        <%--Dt : 13/08/2019--%>

                                        <%--<div class="form_grid" id="dv_IsLrNoUnique" runat="server">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsLrNoUnique"
                                                    Text=" Is LR No. Unique In System" ToolTip="LR No. is unique in system not based on branch and financial year." />
                                            </div>
                                        </div>--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Bilty Print
                                            </div>
                                            <div class="form_fill">
                                                <asp:RadioButtonList Visible="true" RepeatColumns="3" ID="rbl_BiltyPrint" Width="100%" runat="server"
                                                    RepeatDirection="Horizontal" CssClass="margn_l10 margn_r10 font14_blue fill1">
                                                    <asp:ListItem Text=" Is Laser Print" Selected="True" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text=" Pre-Print" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text=" Is Laser Pre-Print" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text=" Is Vertical Print" Value="3"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Print Format
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList ID="dd_PrintFormate" Width="100%" runat="server" TabIndex="-1"
                                                    CssClass="fill">
                                                    <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                    <asp:ListItem Value="1">JALARAM TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="2">VORA TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="3">BOMBAY VERAVAL TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="4">RADHE KRISHNA TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="5">THE NAGPUR GOODS</asp:ListItem>
                                                    <asp:ListItem Value="6">ANMOL TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="7">DELUXE TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="8">SHREE BALAJI TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="9">MP GOLDEN TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="10">3X CARGO CAB</asp:ListItem>
                                                    <asp:ListItem Value="11">RAJESH ROADLINE</asp:ListItem>
                                                    <asp:ListItem Value="12">NEW ERA TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="13">CUBE ONLINE TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="14">NEW ERA TRANSPORT FORMAT 2</asp:ListItem>
                                                    <asp:ListItem Value="15">SHOLAPUR TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="16">FLYWING TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="17">RAJASTHAN TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="18">RAJASTHAN ROAD CARRIER</asp:ListItem>
                                                    <asp:ListItem Value="19">ADITYA SERVICES</asp:ListItem>
                                                    <asp:ListItem Value="20">SURYA ROADWAYS</asp:ListItem>
                                                    <asp:ListItem Value="21">SURYA ONLINE</asp:ListItem>
                                                    <asp:ListItem Value="22">DEEPAK EXPRESS CARGO</asp:ListItem>
                                                    <asp:ListItem Value="23">LALJI-MULJI TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="24">JALARAM TRANSPORT - JTCERP</asp:ListItem>
                                                    <asp:ListItem Value="25">GIZALA21</asp:ListItem>
                                                    <asp:ListItem Value="26">SHREE BALAJI TRANSPORT FORMAT 2</asp:ListItem>
                                                    <asp:ListItem Value="27">CHHEDA CARGO MOVER</asp:ListItem>
                                                    <asp:ListItem Value="28">JAMNAGAR TRAVELS PVT. LTD</asp:ListItem>
                                                    <asp:ListItem Value="29">NEW ANDHRA GUJARAT TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="30">DELHI PEPSU TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="31">JAGDAMBA ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="32">ORGANIZED TRANS SOLUTION</asp:ListItem>
                                                    <asp:ListItem Value="33">ETR-21</asp:ListItem>
                                                    <asp:ListItem Value="34">VASANT LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="35">SAMAY ROADWAYS</asp:ListItem>
                                                    <asp:ListItem Value="36">NUTAN RAJUMANI TRANSPORT </asp:ListItem>
                                                    <asp:ListItem Value="37">SHREE RAM TRANSPORT CORPORATION</asp:ListItem>
                                                    <asp:ListItem Value="38">RPM LOGISTICS PVT LTD.</asp:ListItem>
                                                    <asp:ListItem Value="39">KATARIA CARGO MOVERS</asp:ListItem>
                                                    <asp:ListItem Value="40">GCM ONLINE</asp:ListItem>
                                                    <asp:ListItem Value="41">RAJASTHAN ROAD CARRIER NEW</asp:ListItem>
                                                    <asp:ListItem Value="42">CHHEDA LOGISTIC</asp:ListItem>
                                                    <asp:ListItem Value="43">CHHEDA CARGO MOVERS NEW</asp:ListItem>
                                                    <asp:ListItem Value="44">ATLAS ROADWAYS</asp:ListItem>
                                                    <asp:ListItem Value="45">RAVINDRA TRANSPORT CO.</asp:ListItem>
                                                    <asp:ListItem Value="46">NEW TAKATUKA TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="47">AJAY ROADLINE</asp:ListItem>
                                                    <asp:ListItem Value="48">NEW RPM LOGISTICS PVT LTD.</asp:ListItem>
                                                    <asp:ListItem Value="49">OM MOTORS CARGO CARRIERS</asp:ListItem>
                                                    <asp:ListItem Value="50">KUSHAL ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="51">UNITED TRANSPORT SERVICE</asp:ListItem>
                                                    <asp:ListItem Value="52">RAVINDRA TRANSPORT CO.- PPERP</asp:ListItem>
                                                    <asp:ListItem Value="53">JALARAM TRANSPORT CO.- NEW BILTY PRINT</asp:ListItem>
                                                    <asp:ListItem Value="54">G.SHANTILAL TRANSPORT CO.</asp:ListItem>
                                                    <asp:ListItem Value="55">INDEX ROADWAYS</asp:ListItem>
                                                    <asp:ListItem Value="56">INDEX TRANSPORT CO.</asp:ListItem>
                                                    <asp:ListItem Value="57">KOSA ROADWAYS</asp:ListItem>
                                                    <asp:ListItem Value="58">ARDHANARESHWAR CARGO LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="59">SSR INDIA LOGISTICS </asp:ListItem>
                                                    <asp:ListItem Value="60">DEV ROADWAYS</asp:ListItem>
                                                    <asp:ListItem Value="61">THE NAGPUR GOODS(LASER PRE PRINT)</asp:ListItem>
                                                    <asp:ListItem Value="62">VISHAL GUJARAT LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="63">SHRDDHA MANGE ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="64">SHREE LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="65">C. NARSHI ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="66">SST Logistice</asp:ListItem>
                                                    <asp:ListItem Value="67">WARIS TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="68">SWAMYMALAI TRANSPORTS</asp:ListItem>
                                                    <asp:ListItem Value="69">JEEPXPRESS LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="70">WAIKER TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="71">AG ROADWAYS & LOGISTICS LLP</asp:ListItem>
                                                    <asp:ListItem Value="72">ODHAV ASHISH TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="73">SHIV SAGAR TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="74">Organised Trans Solutions Pvt. Ltd.</asp:ListItem>
                                                    <asp:ListItem Value="75">PANCHMAHAL TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="76">KAPADIA TRANSPORT CO.</asp:ListItem>
                                                    <asp:ListItem Value="77">UTTAM CARGO</asp:ListItem>
                                                    <asp:ListItem Value="78">TAPAN LOGISTIC</asp:ListItem>
                                                    <asp:ListItem Value="79">JANSEVA EXPRESS CARGO</asp:ListItem>
                                                    <asp:ListItem Value="80">Express Online</asp:ListItem>
                                                    <asp:ListItem Value="81">RAJESH ROADLINE Format-2</asp:ListItem>
                                                    <asp:ListItem Value="82">I.P ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="83">SUBHAM EXPRESS CARGO LLP</asp:ListItem>
                                                    <asp:ListItem Value="84">DT Logistics</asp:ListItem>
                                                    <asp:ListItem Value="85">SHRI KRISHNA ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="86">SHANKER ROADWAYS</asp:ListItem>
                                                    <asp:ListItem Value="87">QUICK TRANSPORT SERVICES</asp:ListItem>
                                                    <asp:ListItem Value="88">H.H. ROADWAYS</asp:ListItem>
                                                    <asp:ListItem Value="89">VIKAS ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="90">JALGAON TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="91">SHREE MANMOHAN ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="92">SIDDHI LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="93">PAWAN LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="94">JAY MAA MANSHA TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="95">VIJAY LAXMI TRANSPORT CARRIERS</asp:ListItem>
                                                    <asp:ListItem Value="96">NAVIN ORIENT CARRIER</asp:ListItem>
                                                    <asp:ListItem Value="97">PAWAN GOODS CARRIERS</asp:ListItem>
                                                    <asp:ListItem Value="98">PGC LOGISTIC PVT. LTD.</asp:ListItem>
                                                    <asp:ListItem Value="99">STC LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="100">SANTOSHI TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="101">SOUTH ERP</asp:ListItem>
                                                    <asp:ListItem Value="102">NEW LINE TRANSPORT CO</asp:ListItem>
                                                    <asp:ListItem Value="103">MUMBAI GOLDEN TRANSPORT CO.</asp:ListItem>
                                                    <asp:ListItem Value="104">NAVRANG ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="105">UNJHA RAIPUR TRANSPORT COMPANY</asp:ListItem>
                                                    <asp:ListItem Value="106">DRL LOGISTICS PVT. LTD.</asp:ListItem>
                                                    <asp:ListItem Value="107">SHREE GOODS CARRIERS</asp:ListItem>
                                                    <asp:ListItem Value="108">CHETAN ROADWAYS</asp:ListItem>
                                                    <asp:ListItem Value="109">SHREE YOGI LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="110">JALARAM TRANSCARE</asp:ListItem>
                                                    <asp:ListItem Value="111">SHREE ANMOL TRANSPORT PVT. LTD.</asp:ListItem>
                                                    <asp:ListItem Value="112">BHAVNAGAR ROAD CARGO SERVICE</asp:ListItem>
                                                    <asp:ListItem Value="113">BRL LOGISTIC PRIVATE LIMITED</asp:ListItem>
                                                    <asp:ListItem Value="114">CHARTERED LOGISTICS LIMITED </asp:ListItem>
                                                    <asp:ListItem Value="115">SHREE CARRIERS</asp:ListItem>
                                                    <asp:ListItem Value="116">GANESH ERP</asp:ListItem>
                                                    <asp:ListItem Value="117">INVENT LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="118">BOMBAY BANGALORE FREIGHT CARRIERS PVT. LTD.</asp:ListItem>
                                                    <asp:ListItem Value="119">RAJASTHAN TRANSPORT CORPORATION</asp:ListItem>
                                                    <asp:ListItem Value="120">Famouse Online</asp:ListItem>
                                                    <asp:ListItem Value="121">AMRUT TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="122">AMRUT ROAD WAYS</asp:ListItem>
                                                    <asp:ListItem Value="123">AHMEDABAD RAIPUR TRANSPORT COMPANY</asp:ListItem>
                                                    <asp:ListItem Value="124">RESOURCE LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="125">MALANI FREIGHT CARRIERS</asp:ListItem>
                                                    <asp:ListItem Value="126">SUYOG TRANSPORT COMPANY</asp:ListItem>
                                                    <asp:ListItem Value="127">JAI BALAJI EXPRESS CARGO</asp:ListItem>
                                                    <asp:ListItem Value="128">SAPAN TRANSPORT CO</asp:ListItem>
                                                    <asp:ListItem Value="129">ROYAL INDIA ROADWAYS</asp:ListItem>
                                                    <asp:ListItem Value="130">YASH LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="131">BGFC LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="132">ASTHA ROAD SERVICES</asp:ListItem>
                                                    <asp:ListItem Value="133">VIKAS ROAD CARRIER</asp:ListItem>
                                                    <asp:ListItem Value="134">THE MALHOTRA GOODS CARRIERS</asp:ListItem>
                                                    <asp:ListItem Value="135">SHREE YOGI LOGISTICS FORMAT-2</asp:ListItem>
                                                    <asp:ListItem Value="136">JINESH CARRIERS PVT LTD</asp:ListItem>
                                                    <asp:ListItem Value="137">ANIL BULK CARRIER</asp:ListItem>
                                                    <asp:ListItem Value="138">SHREE ARASURI TRANSPORT COMPANY</asp:ListItem>
                                                    <asp:ListItem Value="139">SKT LOGISTICS PRIVATE LIMITED</asp:ListItem>
                                                    <asp:ListItem Value="140">S M LOGISTICS PVT LTD</asp:ListItem>
                                                    <asp:ListItem Value="141">EMPIRE LOGISTIC</asp:ListItem>
                                                    <asp:ListItem Value="142">YATAYAT CORPORATION OF INDIA</asp:ListItem>
                                                    <asp:ListItem Value="143">SHREE SENTHURAN TRANSPORTS</asp:ListItem>
                                                    <asp:ListItem Value="144">PATEL GOODS FREIGHT CARRIERS</asp:ListItem>
                                                    <asp:ListItem Value="145">JAMNAGAR ROADLINE</asp:ListItem>
                                                    <asp:ListItem Value="146">GAJENDRA ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="147">VINOD FREIGHT CARRIER</asp:ListItem>
                                                    <asp:ListItem Value="148">N R FREIGHT CARRIER</asp:ListItem>
                                                    <asp:ListItem Value="149">INDRAWATI ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="150">JAI MAA KALI ROAD CARRIERS (INDIA)</asp:ListItem>
                                                    <asp:ListItem Value="151">ABCD Soft</asp:ListItem>
                                                    <asp:ListItem Value="152">RAM CARGO CARRIERS</asp:ListItem>
                                                    <asp:ListItem Value="153">GARG TRANSPORT SERVICE</asp:ListItem>
                                                    <asp:ListItem Value="154">GRANVA LOGISTICS PVT. LTD</asp:ListItem>
                                                    <asp:ListItem Value="155">EMPOWER INFRALOGISTICS PVT. LTD</asp:ListItem>
                                                    <asp:ListItem Value="156">SKY BLUE LOGISTICS(INDIA) PVT. LTD</asp:ListItem>
                                                    <asp:ListItem Value="157">SHOLAPUR TRANSPORT CORPORATION</asp:ListItem>
                                                    <asp:ListItem Value="158">SHREE CARRIERS FORMATE2</asp:ListItem>
                                                    <asp:ListItem Value="159">SHREE GANAPATI PARIVAHAN</asp:ListItem>
                                                    <asp:ListItem Value="160">KALPTARU ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="161">KAUSHIK FREIGHT CARRIERS</asp:ListItem>
                                                    <asp:ListItem Value="162">KULDEEP ERP</asp:ListItem>
                                                    <asp:ListItem Value="163">SACHIN TRANSPORT SERVICE</asp:ListItem>
                                                    <asp:ListItem Value="164">RUBY INFRALOGISTICS PVT. LTD</asp:ListItem>
                                                    <asp:ListItem Value="165">AGARWAL TRANSPORT CORPORATION</asp:ListItem>
                                                    <asp:ListItem Value="166">SAIKRUPA LOGISTIC PRIVATE LIMITED</asp:ListItem>
                                                    <asp:ListItem Value="167">JAY TRANSPORT SERVICE</asp:ListItem>
                                                    <asp:ListItem Value="168">PUNJAB GUJARAT TRANSLINK</asp:ListItem>
                                                    <asp:ListItem Value="169">JAY TRANS1</asp:ListItem>
                                                    <asp:ListItem Value="170">DP TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="171">SHRI HANUMAN LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="172">OM ESCORT CARGO</asp:ListItem>
                                                    <asp:ListItem Value="173">NEW MAHAVEER TRANSPORT CO. OF BHARAT</asp:ListItem>
                                                    <asp:ListItem Value="174">EDISAFE LOGISTICS PVT LTD</asp:ListItem>
                                                    <asp:ListItem Value="175">HIMATNAGAR TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="176">PERFECT CARGO LOGISTIC</asp:ListItem>
                                                    <asp:ListItem Value="177">BR Roadways Private Limited</asp:ListItem>
                                                    <asp:ListItem Value="178">FRONTLINE FLEET SERVICES</asp:ListItem>
                                                    <asp:ListItem Value="179">HGT Carrier</asp:ListItem>
                                                    <asp:ListItem Value="180">HANS GROUP CARRIER PVT LTD.</asp:ListItem>
                                                    <asp:ListItem Value="181">SHIVAM ROADWAYS MATHURA</asp:ListItem>
                                                    <asp:ListItem Value="182">JAI AMBE ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="183">ASHISH TRANSPORT SERVICE</asp:ListItem>
                                                    <asp:ListItem Value="184">NIRWAN LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="185">SPEED MOVER</asp:ListItem>
                                                    <asp:ListItem Value="186">Overseas Logistics & Services</asp:ListItem>
                                                    <asp:ListItem Value="187">UR LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="188">SN ROAD LINES</asp:ListItem>
                                                    <asp:ListItem Value="189">Swati Relocations Pvt. Ltd.</asp:ListItem>
                                                    <asp:ListItem Value="190">SREE SHYAM LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="191">New TakaTuka Transport India Reg.</asp:ListItem>
                                                    <asp:ListItem Value="192">SHYAM ROAD CARRIER</asp:ListItem>
                                                    <asp:ListItem Value="193">MY DEC</asp:ListItem>
                                                    <asp:ListItem Value="194">RAMA LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="195">GREEN ROAD CARRIER</asp:ListItem>
                                                    <asp:ListItem Value="196">BATCO ROADLINES LLP</asp:ListItem>
                                                    <asp:ListItem Value="197">SAYONAWARD</asp:ListItem>
                                                    <asp:ListItem Value="198">SRI BALA G LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="199">RAJASTHAN EXPRESS CARGO</asp:ListItem>
                                                    <asp:ListItem Value="200">NG LOGISTICS SOLUTIONS PVT.LTD.</asp:ListItem>
                                                    <asp:ListItem Value="201">SATCERP</asp:ListItem>
                                                    <asp:ListItem Value="202">OM</asp:ListItem>
                                                    <asp:ListItem Value="203">DELHI BHIWANDI ROAD CARRIER</asp:ListItem>
                                                    <asp:ListItem Value="204">KHUSHI ROAD CARRIER</asp:ListItem>
                                                    <asp:ListItem Value="205">HITESH TRANS SYSTEM PVT.LTD.</asp:ListItem>
                                                    <asp:ListItem Value="206">NEW MAHAVEER TRANSPORT COMPANY OF HINDUSTAN</asp:ListItem>
                                                    <asp:ListItem Value="207">BALAJI FREIGHT CARRIER</asp:ListItem>
                                                    <asp:ListItem Value="208">SHREE PRABHAT ROADWAYS SERVICES</asp:ListItem>
                                                    <asp:ListItem Value="209">HITESH TRANS LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="210">TRANS ROAD LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="211">TEJAL EXPRESS CARGO PVT LTD</asp:ListItem>
                                                    <asp:ListItem Value="212">BBR ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="213">BALAJI TRANSPORT CORPORATION(NASHIK)</asp:ListItem>
                                                    <asp:ListItem Value="214">SHREE KRISHNA LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="215">DIVYA ROADLINES</asp:ListItem>
                                                    <asp:ListItem Value="216">UTTRANCHAL TRANSWAYS</asp:ListItem>
                                                    <asp:ListItem Value="217">JP ROADWAYS</asp:ListItem>
                                                    <asp:ListItem Value="218">BHAVNA ROADWAYS</asp:ListItem>
                                                    <asp:ListItem Value="219">SOUTH WEST LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="220">ROSHAN FREIGHT CARRIER LLP</asp:ListItem>
                                                    <asp:ListItem Value="221">SOLTEX PETROPRODUCTS LIMITED</asp:ListItem>
                                                    <asp:ListItem Value="222">CHANDIGARH MAHARASHTRA CARRING CORPORATION PRIVATE LIMITED</asp:ListItem>
                                                    <asp:ListItem Value="223">MY PARDA</asp:ListItem>
                                                    <asp:ListItem Value="224">PRABHAT ROADLINES PRIVATE LIMITED</asp:ListItem>
                                                    <asp:ListItem Value="225">JAMNAGAR GOLDEN CARRIERS PRIVATE LTD</asp:ListItem>
                                                    <asp:ListItem Value="226">RAKESH TRANSPORT CO.</asp:ListItem>
                                                    <asp:ListItem Value="227">VIJAYSINGH BAGHSINGH SHEKHAWAT</asp:ListItem>
                                                    <asp:ListItem Value="228">DEV LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="229">SAHIL CARGO MOVERS</asp:ListItem>
                                                    <asp:ListItem Value="230">CTC INSTA</asp:ListItem>
                                                    <asp:ListItem Value="231">E2E SULPPY CHAIN SOLUTIONS LIMITED</asp:ListItem>
                                                    <asp:ListItem Value="232">NEW MAHAVEER TRANSPORT COMPANY OF ALL INDIA</asp:ListItem>
                                                    <asp:ListItem Value="233">PRABHAT CARRIERS</asp:ListItem>
                                                    <asp:ListItem Value="234">NAV DURGA LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="235">TRINITY LOGISTIX</asp:ListItem>
                                                    <asp:ListItem Value="236">NEW ZAMINDAR TRANSPORT CO.</asp:ListItem>
                                                    <asp:ListItem Value="237">COVER INDIA TRANSPORT CO.</asp:ListItem>
                                                    <asp:ListItem Value="238">KALPTARU XPRESS CARGO PVT LTD.</asp:ListItem>
                                                    <asp:ListItem Value="239">HI-TECH LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="240">SHREE BAJRANG FREIGHT LINE</asp:ListItem>
                                                    <asp:ListItem Value="241">TIME TO TIME LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="242">DURONTO LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="243">VIGNESHWRA TRANSPORT COMPANY</asp:ListItem>
                                                    <asp:ListItem Value="244">1ST SHIVAM TRANS MOVERS PVT LTD</asp:ListItem>
                                                    <asp:ListItem Value="245">RADHIKA EXPRESS PRIVATE LIMITED</asp:ListItem>
                                                    <asp:ListItem Value="246">CNR EXPRESS SERVICE</asp:ListItem>
                                                    <asp:ListItem Value="247">KALPATARU LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="248">GREEN LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="249">SHARDA LLP</asp:ListItem>
                                                    <asp:ListItem Value="250">GANRAJ TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="251">JCPL LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="252">SHREE CHAMUNDA LOGISTIC</asp:ListItem>
                                                    <asp:ListItem Value="253">INDIAN ROAD CARRIERS</asp:ListItem>
                                                    <asp:ListItem Value="254">RAJASTHAN TRANSPORT CORPORATION</asp:ListItem>
                                                    <asp:ListItem Value="255">CALIBRE FREIGHT PVT LTD</asp:ListItem>
                                                    <asp:ListItem Value="256">LUCKY FREIGHT CARRIER</asp:ListItem>
                                                    <asp:ListItem Value="257">RIDHEKART LLP</asp:ListItem>
                                                    <asp:ListItem Value="258">NORTH SOUTH LOGISTIC</asp:ListItem>
                                                    <asp:ListItem Value="259">SUPER TRANS INDIA LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="260">SPEED MOVERS LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="261">STPM LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="262">SAMAY TRANSLINE</asp:ListItem>
                                                    <asp:ListItem Value="263">AJOOBA SERVICES</asp:ListItem>
                                                    <asp:ListItem Value="264">SOMAIYA TRANSPORT</asp:ListItem>
                                                    <asp:ListItem Value="265">JAI MAA LOGISTIC PRIVATE LIMITED</asp:ListItem>
                                                    <asp:ListItem Value="266">JJ LOGISTICS SOLUTION</asp:ListItem>
                                                    <asp:ListItem Value="267">JAI MAA TRANSPORT COMPANY</asp:ListItem>
                                                    <asp:ListItem Value="268">KBS LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="269">VASHISTA LOGISTICS PRIVATE LIMITED</asp:ListItem>
                                                    <asp:ListItem Value="270">INDIA NEPAL HIGHWAY</asp:ListItem>
                                                    <asp:ListItem Value="271">JS SPEED LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="272">ABHAY LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="273">LOGIX SUPPLY CHAIN SOLUTIONS PRIVATE LIMITED</asp:ListItem>
                                                    <asp:ListItem Value="274">BRL LOGISTIKS</asp:ListItem>
                                                    <asp:ListItem Value="275">PUSHPA PAREEK</asp:ListItem>
                                                    <asp:ListItem Value="276">BELGAUM ROAD CARRIER</asp:ListItem>
                                                    <asp:ListItem Value="277">SHRI VIGNESHWARA TRANSPORT COMPANY </asp:ListItem>
                                                    <asp:ListItem Value="278">GALAXY LOGISTICS SERVICES</asp:ListItem>
                                                    <asp:ListItem Value="279">TAKATUKA TRANSPORT ONLINE</asp:ListItem>
                                                    <asp:ListItem Value="280">OPERA LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="281">HGT LOGISTICS</asp:ListItem>
                                                    <asp:ListItem Value="282">CHETAK ROADWAYS(INDIA)</asp:ListItem>
                                                    <asp:ListItem Value="283">GUPTA EXPRESS PRIVATE LIMITED</asp:ListItem>
                                                    <asp:ListItem Value="284">JAIPUR AHMEDABAD TRANSPORT COMPANY</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Bilty By Def. Print
                                            </div>
                                            <div class="form_fill">
                                                <asp:RadioButtonList Visible="true" RepeatColumns="4" ID="rbl_BiltyNoOfPrint" Width="100%" runat="server"
                                                    RepeatDirection="Horizontal" CssClass="margn_l10 margn_r10 font14_blue fill1">
                                                    <asp:ListItem Text=" 1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text=" 2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text=" 3" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text=" 4" Value="4"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Door Dty or Go Down
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList CssClass="fill"
                                                    ID="chk_Risk" runat="server">
                                                    <asp:ListItem Text=" Godown" Value="1"></asp:ListItem>
                                                    <asp:ListItem Selected="True" Text=" Door Delivery" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text=" Carriers’s Risk With Door Delivery" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text=" Carriers’s Risk With Godown Delivery" Value="4"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Service Tax Paid By
                                            </div>
                                            <div class="form_fill">
                                                <asp:RadioButtonList Visible="true" ID="rbl_STaxPaidBy" Width="100%" runat="server"
                                                    RepeatDirection="Horizontal" RepeatColumns="3" CssClass="fill">
                                                    <asp:ListItem Text=" Consignor" Selected="True" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text=" Consignee" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text=" Transport" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text=" Full Service Tax" Value="4"></asp:ListItem>
                                                    <asp:ListItem Text=" Bill On" Value="5"></asp:ListItem>
                                                    <asp:ListItem Text=" GST" Value="6"></asp:ListItem>
                                                    <asp:ListItem Text=" GST For Train" Value="7"></asp:ListItem>
                                                    <asp:ListItem Text=" GST For Air" Value="8"></asp:ListItem>
                                                    <asp:ListItem Text=" GST For Sea" Value="9"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Consignee & Consignor Auto Add In Bilty
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_ConsigneeAdd"
                                                    Text=" Is Consignee & Consignor Auto Add" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Km. Per Hours
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_KmPerHours" runat="server" CssClass="fill" MaxLength="3"
                                                    Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsFreightRoundOffInLR"
                                                    Text=" Is Freight Round Off In LR" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsChargeWeightRoundOffInLR"
                                                    Text=" Is Charge Weight Round Off In LR" Width="68%" Style="margin-right: 1%" />
                                                <asp:DropDownList ID="dd_RoundOffWtinLR" Width="25%" runat="server"
                                                    CssClass="fill">
                                                    <%--<asp:ListItem Text="--Select--" Selected="True" Value="0"></asp:ListItem>--%>
                                                    <asp:ListItem Text=" 5" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text=" 10" Value="2"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <%--if contant checked true than display same table other wise Master table--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsContantDisplayInMaster"
                                                    Text=" Only Master Contains Display In LR" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Set Default Button
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList ID="dd_SetDefaultButton" Width="53%" runat="server"
                                                    CssClass="fill">
                                                    <asp:ListItem Text=" None" Selected="True" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text=" Save & Print" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text=" Save & Next" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text=" Save" Value="3"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Rate Type
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList ID="dd_RateType" Width="53%" runat="server"
                                                    CssClass="fill">
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Carrier Type
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList ID="dd_CarrierType" Width="53%" runat="server"
                                                    CssClass="fill">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsFilledbyMobileNo"
                                                    Text=" Is Consignor Consignee Auto fill base on Mobile No." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsCopyLRButtonVisible"
                                                    Text=" Is Copy LR Button Visible In Bilty Entry" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DDChgReqDependsOnDelType"
                                                    Text=" DD Charge Require Depends On Delivery Type ?" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_right">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Bilty By Default
                                            </div>
                                            <div class="form_fill">
                                                <asp:RadioButtonList Visible="true" RepeatColumns="3" ID="rbl_BiltyByDefault" Width="100%" runat="server"
                                                    RepeatDirection="Horizontal" CssClass="margn_l10 margn_r10 font14_blue fill1">
                                                    <asp:ListItem Text=" Machine Wise" Selected="True" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text=" General Wise" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text=" Multiple List" Value="2"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                St (Docate) Charge
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_DocateCharge" runat="server" CssClass="fill" MaxLength="3"
                                                    Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Round Off Charge
                                            </div>
                                            <div class="form_fill">

                                                <asp:DropDownList ID="dd_RoundOffCharge" Width="53%" runat="server" TabIndex="22"
                                                    CssClass="fill">
                                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Lr Type 
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList ID="dd_LrType" Width="53%" runat="server" TabIndex="22"
                                                    CssClass="fill">
                                                </asp:DropDownList>

                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill b_float" ID="cb_RemovePaidLrType" Text=" Remove Paid Lr Type" Width="39%" Checked="true" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_IsLrVehicle"
                                                    Text=" Is LR Vehicle No Auto Update" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_IsAutoSelectedFrtAt"
                                                    Text=" Is Frt At Auto Selected In Bilty" Width="52%" />
                                                <asp:DropDownList ID="ddl_FreightAtBranch" Width="42%" runat="server"
                                                    CssClass="fill" Style="height: 34px; margin-left: 5px;">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Station Auto Add In Bilty
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_StationAdd"
                                                    Text=" Is Station Auto Add" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Extra Days
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_ExtraDays" runat="server" CssClass="fill" MaxLength="3"
                                                    Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Working Hours
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_WorkingHours" runat="server" CssClass="fill" MaxLength="3"
                                                    Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Ch_BiltyIsPaidAutoToCashOrCheque"
                                                    Text=" Bilty Is Paid Auto To Cash Or Cheque" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Ch_BiltyIsSerialFileUpload"
                                                    Text=" Bilty Is Serial File Upload" />
                                            </div>
                                        </div>
                                        <div class="form_grid" style="display: none">
                                            <div class="form_lab">
                                                Margin Top
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_MarginTop" runat="server" CssClass="fill" MaxLength="8"
                                                    Font-Size="Small" onkeypress="return Numericdotonly(event,this.id);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid" style="display: none">
                                            <div class="form_lab">
                                                Margin Left
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_MarginLeft" runat="server" CssClass="fill" MaxLength="8"
                                                    Font-Size="Small" onkeypress="return Numericdotonly(event,this.id);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid" style="display: none">
                                            <div class="form_lab">
                                                Margin Right
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_MarginRight" runat="server" CssClass="fill" MaxLength="8"
                                                    Font-Size="Small" onkeypress="return Numericdotonly(event,this.id);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid" style="display: none">
                                            <div class="form_lab">
                                                Margin Bottom
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_MarginBottom" runat="server" CssClass="fill" MaxLength="8"
                                                    Font-Size="Small" onkeypress="return Numericdotonly(event,this.id);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Contract Type
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList ID="dd_PkgType" Width="53%" runat="server" TabIndex="22"
                                                    CssClass="fill">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsGenerateBarcodeLR"
                                                    Text="Is Generated Barcode for LR." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsCustomerWiseWeight"
                                                    Text=" Is Customer Wise Weight?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendMailToConsigneeConsignor"
                                                    Text=" Is Send Mail To Consignee Consignor?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendMailToBookingBranch"
                                                    Text=" Is Send Mail To Booking Branch ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoFillBiltyEntryOnSaveNext"
                                                    Text=" Is Auto Fill Bilty Entry on Save & Next?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDocatChargeEnablePVFreight"
                                                    Text=" Is Docate Charge zero when Enable Pv Freight?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoAdvanceInLR"
                                                    Text=" Is Auto Advance?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsFreightRateDependsOnContract"
                                                    Text=" Is Freight Rate Depends on Contract?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                <asp:Label ID="l_IBranchInvVal" runat="server" Text="InterBranch Invoice Value"></asp:Label>
                                                <asp:Label ID="l_OBranchInvVal" runat="server" Text="OuterBranch Invoice Value" Style="float: right"></asp:Label>
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_InterBranchValue" Width="40%" runat="server" CssClass="fill">
                                                </asp:TextBox>
                                                <asp:TextBox ID="tb_OuterBranchValue" Width="40%" runat="server" CssClass="fill" Style="float: right">
                                                </asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab"></div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsEWayBillNoUnique" Text=" Is E-Way Bill No. Unique ?" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Bilty Field Not To Display In Form
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="ch_Goe_CarrierTypeNotdisplayinform"
                                                    Text=" Is Display Carrier Type In Form" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredCarrierType"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_Goe_InsuranceNotdisplayinform"
                                                    Text=" Is Display Insurance In Form" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_Goe_FormNotdisplayinform"
                                                    Text=" Is Display Form No. In Form" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="ch_Goe_valuenotdisplayinform"
                                                    Text=" Is Display Value In Form" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredValue"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_MarchantName"
                                                    Text=" Is Display Processor Name/LR Ref/Merchant Name/Lot No" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_ConPkgType"
                                                    Text=" Is Display Content Package Type" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsReqConPkgType"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_PrivetMarksingle"
                                                    Text=" Private Mark (Single)" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisplayESugamNoInLR"
                                                    Text=" Is Disp. E-Sugam/E-WayBill No In LR" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredEwayBillNoInLr"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisplayPartyInvoiceDateInLR"
                                                    Text=" Is Display Party Invoice Date In LR" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredPartyInvoiceDate"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayLength"
                                                    Text=" Is Display Length in Form" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayHeight"
                                                    Text=" Is Display Height In Form" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayLengthInMultiple"
                                                    Text=" Is Display Length Multple/Machine Entry" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayWidthInMultiple"
                                                    Text=" Is Display Width Multple/Machine Entry" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayHeightInMultiple"
                                                    Text=" Is Display Height Multple/Machine Entry" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_ReferenceNo"
                                                    Text=" Is Display Reference No" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_ServiceEntryNo"
                                                    Text=" Is Display Service Entry No" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_DeliveryRecNo"
                                                    Text=" Is Display Delivery Receipt/Order No" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsDeliverRecNoReq"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_PoNo"
                                                    Text=" Is Display Purchase Order No" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsPurchaseOrderNoRequired"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayBookingBranch"
                                                    Text=" Is Display Booking Branch ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayConsignment"
                                                    Text=" Is Display Consignment ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayBookingTerms"
                                                    Text=" Is Display Booking Terms ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayConsignorAdd"
                                                    Text=" Is Display Consignor Address?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayContractType"
                                                    Text=" Is Display Contract Type" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayFromStationLR"
                                                    Text="Is Display From Station in LR." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsHideBilledOn"
                                                    Text=" Is Display Billed On For To Pay?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayMaterialName"
                                                    Text=" Is Display Material Name ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplaySealNumber"
                                                    Text=" Is Display Seal Number ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayActWeight"
                                                    Text=" Is Not Display Actual Weight ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_SendArrivalAlertMailtoConsignee"
                                                    Text="Is Send Arrival Alert Mail to Consignee ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_IsDisplayDeliveryAdd"
                                                    Text="Is Display Delivery Address?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_IsDisplayMIRODOCNo"
                                                    Text="Is Display MIRO DOC No. ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_IsDisplayShipmentCostNo"
                                                    Text="Is Display Shipment Cost No. ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCubicFeet"
                                                    Text=" Is Display Cubic Feet ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:Label ID="l_DefText" runat="server" Font-Bold="true" CssClass="fill width71box" Text="Default Grid Rows For Multiple/Machine Wise"></asp:Label>
                                                <asp:TextBox runat="server" MaxLength="2" onkeypress="return Numericdotonly(event,this.id);" CssClass="fill width18per" ID="tb_DefaultGridRowBilty" />
                                            </div>
                                        </div>
                                        <%--<div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayNoofExtraPoint"
                                                    Text=" Is Display No. of Extra Point ?" />
                                            </div>
                                        </div>--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisplayEwbExpDate"
                                                    Text=" Is Display E-Waybill Exp. Date" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsReqEwbExpDate"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayDistrict"
                                                    Text=" Is Display District ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayPolicyCompName"
                                                    Text=" Is Display Policy Company Name?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisplayGrossTareWt"
                                                    Text=" Is Display Gross & Tare Wt?" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredGrossTareWt"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayStoNo"
                                                    Text="Is Display STO No.?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayGanNo"
                                                    Text="Is Display GAN No.?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayBillingDocketNo"
                                                    Text="Is Display Billing Docket No.?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayBillingDocketDate"
                                                    Text="Is Display Billing Docket Date?" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_right">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="ch_Goe_Partyinvnotdisplayinform"
                                                    Text=" Is Display Party Invoice No." />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredPartyInvoiceNo"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_Goe_Vehicalnonotdisplayinform"
                                                    Text=" Is Display Vehicle No. In Form" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_Goe_KmNotDisplayinForm"
                                                    Text=" Is Display Kilometer In Form" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_BiltyAdvance"
                                                    Text=" Is Display Advance In Form" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_PrivateMarks"
                                                    Text=" Is Display Private Marks In Form" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsReqPrivateMarks"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayDistance"
                                                    Text=" Is Display Distance" Width="49%" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill b_float" ID="cb_IsEnableDistance"
                                                    Text=" Is Distance Enable ?" Width="39%" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisplayTinNo"
                                                    Text=" Is Display Tin No. In Form" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredTinNo"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsCcAttached"
                                                    Text=" Is Display Cc Attached In Form" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayWidth"
                                                    Text=" Is Display Width in Form" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" onchange="ShowFreightTOPay();" CssClass="fill" ID="cb_IsMinimumFreight"
                                                    Text=" Is Freight Minimum In Form (To Pay)" Width="61%" />
                                                <asp:TextBox ID="tb_MinimumFreight" runat="server" CssClass="fill b_float" Width="29%" Style="display: none;" MaxLength="8"
                                                    Font-Size="Small" onkeypress="return Numericdotonly(event,this.id);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" onchange="ShowFreightTBB();" CssClass="fill" ID="cb_IsMaximumFreight"
                                                    Text=" Is Freight Maximum In Form (TBB)" Width="61%" />
                                                <asp:TextBox ID="tb_MaximumFreight" runat="server" CssClass="fill b_float" Width="29%" Style="display: none;" MaxLength="8"
                                                    Font-Size="Small" onkeypress="return Numericdotonly(event,this.id);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsConMobReqired"
                                                    Text=" Is Required Consignee Consignor Mobile No" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_CustomerLrNo"
                                                    Text=" Is Display Customer Lr No" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredCustomerLrNo"
                                                    Text=" Is Required Customer Lr No" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_ShipmentNo"
                                                    Text=" Is Display Shipment No" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsServiceTaxRoundOff"
                                                    Text=" Is Service Tax Round Off In LR" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayConsignmentNoTwo"
                                                    Text=" Is Display Consignment No Two?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayFreightAt"
                                                    Text=" Is Display Freight At ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayConsigneeAdd"
                                                    Text=" Is Display Consignee Address?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplaySupplimentryBilty"
                                                    Text=" Is Display Checkbox of Supplimentry Bilty" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayToStationLR"
                                                    Text=" Is Display To Station in LR." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredToStationLR"
                                                    Text=" Is Required To Station in LR." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisplayMaterialType"
                                                    Text=" Is Display Material Type in LR." />

                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredMaterialType" Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayJobNumber"
                                                    Text=" Is Display Job No/Booking No ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayContainerNumber"
                                                    Text=" Is Display Container Number ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayBENumber"
                                                    Text=" Is Display BE Number ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayEmptyDate"
                                                    Text=" Is Display Empty Date/Stuffing Date ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayChargeUpto"
                                                    Text=" Is Display Charge Upto ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayChargeWeight"
                                                    Text=" Is Not Display Charge Weight?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCubicmeter"
                                                    Text=" Is Display Cubic Meter ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayActualCMT"
                                                    Text=" Is Display Actual CMT ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayFiVoucherNo"
                                                    Text=" Is Display Fi Voucher No. ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayExtraCubicFeet"
                                                    Text=" Is Display Extra Cubic Feet ?" />
                                            </div>
                                        </div>


                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayLRChargeableDays"
                                                    Text=" Is Display Chargeable Days ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisplayHSNCode"
                                                    Text=" Is Display HSN Code" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsReqHSNCode"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayTaluka"
                                                    Text=" Is Display Taluka ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayPolicyNo"
                                                    Text=" Is Display Policy No.?" />
                                            </div>
                                        </div>

                                        <%--17/04/2020--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisplayModeofTransportation"
                                                    Text=" Is Display Mode Of Transportation In Form" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredModeofTransportation"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisplayLoadType"
                                                    Text=" Is Display Load Type In Form" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredLoadType"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <%--17/04/2020--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayKotNo"
                                                    Text="Is Display KOT No.?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayPODate"
                                                    Text="Is Display PO Date?" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <table style="width: 100%; border: 1px solid #B1B1B1; border-collapse: collapse;">
                                        <tr>
                                            <td>
                                                <b>Bilty Charges :</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="form_left">
                                                    <div id="charges" runat="server">
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayHamali"
                                                                    Text=" Is Display Hamali ?" />
                                                            </div>
                                                        </div>
                                                        <%-- Hamali--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayDetantion"
                                                                    Text=" Is Display Detantion ?" />
                                                            </div>
                                                        </div>
                                                        <%--Detantion--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayDDCharge"
                                                                    Text=" Is Display DD Charge ?" />
                                                            </div>
                                                        </div>
                                                        <%--DD Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayCollCharge"
                                                                    Text=" Is Display Collection Charge ?" />
                                                            </div>
                                                        </div>
                                                        <%--Collection Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayOtherCharge"
                                                                    Text=" Is Display Other Charge ?" />
                                                            </div>
                                                        </div>
                                                        <%--Other Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayDocketCharge"
                                                                    Text=" Is Display Docket Charge ?" />
                                                            </div>
                                                        </div>
                                                        <%--Docket Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayEssOrOda"
                                                                    Text=" Is Display Ess Or Oda ?" />
                                                            </div>
                                                        </div>
                                                        <%--Ess Or Oda--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_FovCharges"
                                                                    Text=" Is FOV(Freight On Income) In LR" />
                                                            </div>
                                                        </div>
                                                        <%--FOV--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_AOCCharges"
                                                                    Text=" Is AOC(Additional Operating Cost) In LR" />
                                                            </div>
                                                        </div>
                                                        <%--Aoc--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_ccattachedcharges"
                                                                    Text=" Is CC Attached In LR" />
                                                            </div>
                                                        </div>
                                                        <%--CC Attached--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayFSCCharge"
                                                                    Text=" Is Display FSC Charge?" />
                                                            </div>
                                                        </div>
                                                        <%--fsc Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayLengthCharge"
                                                                    Text=" Is Display Length Charge" />
                                                            </div>
                                                        </div>
                                                        <%--length charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayTopayCharge"
                                                                    Text=" Is Display Topay Charge?" />
                                                            </div>
                                                        </div>
                                                        <%--Topay Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayPvFreight"
                                                                    Text="Is Display Pv. Freight in LR." />
                                                            </div>
                                                        </div>
                                                        <%--Pv. Freight--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayEWayBillCharge"
                                                                    Text="Is Display E-WayBill Charge" />
                                                            </div>
                                                        </div>
                                                        <%--E-WayBill Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayReturnCharge"
                                                                    Text="Is Display Return Charge" />
                                                            </div>
                                                        </div>
                                                        <%--Return Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayParkingCharge"
                                                                    Text=" Is Display Parking Charge ?" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form_right">
                                                    <div id="charge2" runat="server">
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayCODDODDACCCharges"
                                                                    Text=" Is Display COD/DOD/DACC Charge?" />
                                                            </div>
                                                        </div>
                                                        <%--COD/DOD/DACC Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayDemurrageCharge"
                                                                    Text=" Is Display Demurrage Charge ?" />
                                                            </div>
                                                        </div>
                                                        <%--Demurrage Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayAwbCharge"
                                                                    Text=" Is Display Airway Bill Charge?" />
                                                            </div>
                                                        </div>
                                                        <%--awb Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayNFormCharge"
                                                                    Text=" Is Display N Form Charge?" />
                                                            </div>
                                                        </div>
                                                        <%--n form charge --%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayWarehouseCharge"
                                                                    Text=" Is Display Warehouse Charge?" />
                                                            </div>
                                                        </div>
                                                        <%--Warehouse Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayUnloadingCharge"
                                                                    Text=" Is Display Unloading Charge?" />
                                                            </div>
                                                        </div>
                                                        <%--Unloading Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayExtraPointCharge"
                                                                    Text=" Is Display Extra Point Charge?" />
                                                            </div>
                                                        </div>
                                                        <%--Extra Point Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCommissionCharge"
                                                                    Text=" Is Display Commission Charge ?" />
                                                            </div>
                                                        </div>
                                                        <%--Commission Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplay2ndDeliveryCharge"
                                                                    Text=" Is Display 2nd Delivery Charge ?" />
                                                            </div>
                                                        </div>
                                                        <%--2nd Delivery Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayExtraVillage"
                                                                    Text=" Is Display Extra village Charge?" />
                                                            </div>
                                                        </div>
                                                        <%--Extra village Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsDisplayOverloadCharge"
                                                                    Text=" Is Display Overload Charge?" />
                                                            </div>
                                                        </div>
                                                        <%--Overload Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayGreenTax"
                                                                    Text=" Is Display Green Tax ?" />
                                                            </div>
                                                        </div>
                                                        <%--Green Tax--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayRiskCharge"
                                                                    Text=" Is Display Risk Charge?" />
                                                            </div>
                                                        </div>
                                                        <%--Risk Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayLRRtoCharge"
                                                                    Text=" Is Display Rto Charge ?" />
                                                            </div>
                                                        </div>
                                                        <%--RTO Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayTollTaxCharge"
                                                                    Text=" Is Display Toll Tax Charge ?" />
                                                            </div>
                                                        </div>
                                                        <%--TollTax Charge--%>

                                                        <%--Union Charge--%>
                                                        <div class="form_grid">
                                                            <div class="form_lab">
                                                            </div>
                                                            <div class="form_fill">
                                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayUnionCharge"
                                                                    Text=" Is Display Union Charge ?" />
                                                            </div>
                                                        </div>
                                                        <%--Union Charge--%>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Challan Setting
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendSmsInChallan"
                                                    Text=" Is Send SMS In Challan" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" onclick="IsChlNoDisable(this.checked);" ID="ch_IsChallanAutoNo"
                                                    Text=" Is Challan Auto No. (Unique Branch Wise)" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Contract Type
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList ID="dd_ChallanContractType" Width="53%" runat="server" CssClass="fill">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList runat="server" ID="dd_ChallanWise" class="fill" Width="100%">
                                                    <asp:ListItem Value="0" Selected="True"> Unique Branch Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="1"> Is Challan No. Unique Company Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="2"> Is Challan No. Unique In System </asp:ListItem>
                                                    <asp:ListItem Value="3"> Is Challan No. Unique Branch Wise </asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid" id="dv_IsChallanDisable" runat="server" style="display: none">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsChNoDisable"
                                                    Text=" Is Challan Auto No Disable" />
                                            </div>
                                        </div>
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsChallanNoSeriesWise"
                                                    Text=" Is Challan No. Series Wise" />
                                            </div>
                                        </div>
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_IsBhadaChithi"
                                                    Text=" Is Challan Required Bhada Chithi No." />
                                            </div>
                                        </div>
                                        <div class="form_grid" style="display: none;">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_AllowLrInChallan"
                                                    Text=" Allow Other LR In Challan" />
                                            </div>
                                        </div>
                                        <%--<div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_AllowOtherChlInHpa"
                                                    Text=" Allow Other Challan In Hire Pay Advice" />
                                            </div>
                                        </div>--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsChallanRecWise"
                                                    Text=" Is LR Allow Receipt Confirmation Wise In Challan" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsPanNoRequired"
                                                    Text=" Is Pan No Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsChlDisplayPPName"
                                                    Text=" Is Display Petrol Pump Name In Challan Entry ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsChlDieselQuantity"
                                                    Text=" Is Display Diesel Quantity In Challan Entry ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsChlAgentName"
                                                    Text=" Is Display Agent Name ?" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredAgentName"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DriverNameRequired"
                                                    Text=" Is Driver Name Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_BrokerNameBaseOnMaster"
                                                    Text=" Is Broker Name Base On Master" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_ChallanNo2"
                                                    Text=" Is Display Challan No. 2" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_CarrierType"
                                                    Text=" Is Display Carrier Type" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredCarrierTypeInChallan"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_Form15"
                                                    Text=" Is Display Form 15 in Challan" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendMailChallanEntry"
                                                    Text=" Is Send Mail On Create Challan Entry ?" />
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_SendMailIdChallanEntry" runat="server" CssClass="fill_txt" placeholder="Send Email On Create Challan Entry - Email Id" TextMode="MultiLine" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayChlFromStation"
                                                    Text=" Is Display From Station" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayChlToStation"
                                                    Text=" Is Display To Station" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsAutoEntryAdvanceInChallan"
                                                    Text=" Is Auto Advance Entry In Cash OR Bank?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispStartKMChallan"
                                                    Text=" Is Display Start KM in Challan ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:Label ID="Label3" runat="server" Font-Bold="true" CssClass="fill width71box" Text=" Default LR Show In Grid"></asp:Label>
                                                <asp:TextBox ID="tb_DefaultLRRowsChl" Style="font-size: Small;" runat="server" CssClass="fill width18per" MaxLength="3"
                                                    Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsReqDriverNameInTripSheet"
                                                    Text=" Is Driver Name Required in Trip Sheet Entry ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispTripSheetChallanFrghtInHire"
                                                    Text=" Is Display Tripsheet Challan Freight in Hire?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayAdvCashBankTripsheet"
                                                    Text=" Is Display Cash/Bank Advance Vehicle Ledger Wise in Tripsheet?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:Label ID="lbl_DefaultJVEntryinTrip" Height="20px" Width="55%" align="center" runat="server" Font-Bold="true" CssClass="fill width71box margin2per" Text="Set Default JV in Tripsheet"></asp:Label>
                                                <asp:DropDownList ID="dd_DefaultJVEntryinTrip" runat="server" CssClass="fill1" Width="35%" Height="39px">
                                                    <asp:ListItem Value="0" Text="-- None --"></asp:ListItem>
                                                    <asp:ListItem Value="1" Text="Driver Wise"></asp:ListItem>
                                                    <asp:ListItem Value="2" Text="Trip Wise"></asp:ListItem>
                                                    <asp:ListItem Value="3" Text="Vehicle Wise"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayConsolidateEWayBillNoinChallan"
                                                    Text=" Is Display Consolidated E-Way Bill No in Challan?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRateHideUserRightsWise"
                                                    Text=" Is Rate and RateType Editable in Challan For User?" />
                                            </div>
                                        </div>
                                        <%--Dt:25/06/2019   Is Balance Depends on POD?--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsBalanceDependsonPOD"
                                                    Text=" Is Balance Depends on POD ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsTripChargesDependsOnTripVehicleDistance"
                                                    Text=" Is Tripsheet Charges Depends On Trip Vehicle Distance ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_AutoChallaninHPAbyBhadaChithiNo"
                                                    Text=" Is Auto Update Challan In HPA By Bhada Chithi No. ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayLoadingByinChallan"
                                                    Text=" Is Display Loading By in Challan ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendChallanEntryAdvanceSMS"
                                                    Text=" Is Allow Challan Entry - Advance SMS ?" />
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_SendChallanEntryAdvanceSMSMobileNo" runat="server" CssClass="fill_txt" placeholder="Challan Entry - Send Advance SMS - Mobile No." TextMode="MultiLine" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_GenerateAdvancePaymentRequestinChallan"
                                                    Text=" Is Generate Advance Payment Request by Trip Distance in Challan ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsChallanVehNoBaseOnReceiptConf"
                                                    Text=" Is Vehicle No. Base on Receipt Confirmation ?" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_right">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Challan Print
                                            </div>
                                            <div class="form_fill">
                                                <asp:RadioButtonList Visible="true" RepeatColumns="3" ID="rbl_ChallanPrint" Width="100%" runat="server"
                                                    RepeatDirection="Horizontal" CssClass="margn_l10 margn_r10 font14_blue fill1">
                                                    <asp:ListItem Text=" Is Laser Print" Selected="True" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text=" Pre-Print" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text=" Is Leser Pre-Print" Value="2"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Challan By Def. Print
                                            </div>
                                            <div class="form_fill">
                                                <asp:RadioButtonList Visible="true" RepeatColumns="3" ID="rbl_ChallanNoOfPrint" Width="100%" runat="server"
                                                    RepeatDirection="Horizontal" CssClass="margn_l10 margn_r10 font14_blue fill1">
                                                    <asp:ListItem Text=" 1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text=" 2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text=" 3" Value="3"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <%--<div class="form_grid" style="padding-top: 8px;">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsHpaAutoNo"
                                                    Text=" Is Hire Payment Advice Auto No." />
                                            </div>
                                        </div>--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsChlDelivery"
                                                    Text=" Allow Delivery LR in Challan " />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsEwayBillRequiredinChallan"
                                                    Text=" Is E-Way Bill No required in Challan " />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsTripSheetAutoNo"
                                                    Text=" Is Trip Sheet Auto No." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:Label ID="Label2" Height="20px" Width="55%" align="center" runat="server" Font-Bold="true" CssClass="fill width71box" Text=" Form 15"></asp:Label>
                                                <asp:DropDownList ID="dd_FormType" Width="38%" runat="server" TabIndex="22"
                                                    CssClass="fill b_float">
                                                    <asp:ListItem Text="Y" Value="Y"></asp:ListItem>
                                                    <asp:ListItem Text="N" Value="N"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsOwnerNameRequired"
                                                    Text=" Is Owner Name Required In Challan Entry" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">

                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispOwnerNameChln"
                                                    Text=" Is Owner Name Display" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRepeatAllow"
                                                    Text=" Is Challan Repeat Allow" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_ContractType"
                                                    Text=" Is Display Contract Type" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_BhadaChithiNo"
                                                    Text=" Is Display Bhada Chithi No." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsLrBaseOnBrnSt"
                                                    Text=" Is Lr Base On Station/Branch ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisplayChlDriverMobileNo"
                                                    Text=" Is Display Driver Mobile No. ?" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredDriverMobileNo"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayLicenceNoInChallan"
                                                    Text=" Is Display Licence No." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispDieselAmountChallan"
                                                    Text=" Is Display Diesel Amount in Challan ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoEntryDiesel"
                                                    Text=" Is Auto Entry Diesel In Challan." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayReachingDate"
                                                    Text=" Is Display Reaching Date & Time" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispalyAccountLedger"
                                                    Text=" Is Display Account Ledger?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispSearchLRNo"
                                                    Text=" Is Display Search LR No.?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayfromDieselInTripsheet"
                                                    Text=" Is Display Diesel Detail from Diesel-IN in TripSheet?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisAutoDeliveryInReceiptConf"
                                                    Text=" Is Display Auto Delivery In Receipt Confirmation" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispVehicleWiseOpeningTripsheet"
                                                    Text=" Is Display Vehicle Wise Opening in Tripsheet ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_PickuprequiredForLr"
                                                    Text=" Is Pickup Required For Lr ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_KMRequiredForChallanInTrip"
                                                    Text=" Is KM Required For Challan Detail In TripSheet ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCashByPumpInChallan"
                                                    Text=" Is Display Cash By Pump in Challan Entry ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayBalPaymentCommisionPercentageChl"
                                                    Text=" Is Display Bal.Payment Commision on Percentage ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsLrAmountLessThenChallanAmount"
                                                    Text=" Is Lr Amount Greater then Challan Amount ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCardPumpinChallan"
                                                    Text=" Is Display Pump Card in Challan ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_DisplayKilometerinChallan"
                                                    Text=" Is Display Kilometer in Challan ?" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_RequiredKilometerinChallan"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_Sett_AutoTripByChallan"
                                                    Text=" Is Allow Auto Tripsheet By Challan Entry?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsVehNoBaseOnMasterInChallan"
                                                    Text=" Is Vehicle No. Base On Master (Pickup/Internal/Challan/HPA/Local Driver/Crossing Memo)" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendChallanEntryDieselSMS"
                                                    Text=" Is Allow Challan Entry - Diesel SMS ?" />
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_SendChallanEntryDieselSMSMobileNo" runat="server" CssClass="fill_txt" Placeholder="Challan Entry - Send Diesel SMS Mobile No." TextMode="MultiLine" MaxLength="200" Font-Size="Small"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayRateFreightUserwithoutRate"
                                                    Text=" Is display Rate & Freight to User without Rate ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsManualTripnoUniqueinTripsheet"
                                                    Text=" Is Manual Trip No. Unique in Tripsheet ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendChallanEntryOwnerSMS"
                                                    Text=" Is Allow Challan Entry - Owner SMS ?" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <table style="width: 100%; border: 1px solid #B1B1B1; border-collapse: collapse;">
                                        <tr>
                                            <td>
                                                <b>Challan Charges :</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="form_left">
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispRateFreight"
                                                                Text=" Is Display Rate & Freight" />
                                                        </div>
                                                    </div>
                                                    <%--Rate & Freight--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispLessDeduction"
                                                                Text=" Is Display Less Deduction" />
                                                        </div>
                                                    </div>
                                                    <%--Less Deduction--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_LoadingCharge"
                                                                Text=" Is Display Loading Charge" />
                                                        </div>
                                                    </div>
                                                    <%--Loading Charge--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_OtherCharge"
                                                                Text=" Is Display Other Charge" />
                                                        </div>
                                                    </div>
                                                    <%--Other Charge--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayDeliveryCharge"
                                                                Text=" Is Display Delivery Charge" />
                                                        </div>
                                                    </div>
                                                    <%--Delivery Charge--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_AdvanceAmount"
                                                                Text=" Is Display Advance Amount" />
                                                        </div>
                                                    </div>
                                                    <%--Advance--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_ClaimCharge"
                                                                Text=" Is Display Claim Charge" />
                                                        </div>
                                                    </div>
                                                    <%--Claim Charge--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_LetDeliveryCharge"
                                                                Text=" Is Display Let Delivery Charge" />
                                                        </div>
                                                    </div>
                                                    <%--Let Delivery Charge--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_BalPaymentCharge"
                                                                Text=" Is Display Bal. Payment Charge" />
                                                        </div>
                                                    </div>
                                                    <%--Bal. Payment Charge--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayContStationery"
                                                                Text=" Is Display Container Stationery" />
                                                        </div>
                                                    </div>
                                                    <%--Container Stationery--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayMiscIncome"
                                                                Text=" Is Display Miscellaneous Income" />
                                                        </div>
                                                    </div>
                                                    <%--Miscellaneous Income--%>
                                                    <%--Crossing Charge--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsDisCrossingChg"
                                                                Text=" Is Display Crossing Charge" />
                                                        </div>
                                                    </div>

                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayOwnVehicleFreight" Text=" Is Display Own Vehicle Freight." />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form_right">
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayALHInterest"
                                                                Text=" Is Display ALH Interest" />
                                                        </div>
                                                    </div>
                                                    <%--ALH Interest--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DetantionCharge"
                                                                Text=" Is Display Detantion Charge" />
                                                        </div>
                                                    </div>
                                                    <%--Detantion Charge--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HireCharge"
                                                                Text=" Is Display Hire Charge" />
                                                        </div>
                                                    </div>
                                                    <%--Display Hire Charge--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_UnloadingCharge"
                                                                Text=" Is Display Unloading Charge" />
                                                        </div>
                                                    </div>
                                                    <%--Unloading Charge--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayHeightCharge"
                                                                Text=" Is Display Height Charge" />
                                                        </div>
                                                    </div>
                                                    <%--HeightCharge--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayTollCharge"
                                                                Text=" Is Display Toll Charge" />
                                                        </div>
                                                    </div>
                                                    <%--TollCharge--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsDisplayExtraChargeDimWt"
                                                                Text=" Is Display Extra Charge DIM. & WT." />
                                                        </div>
                                                    </div>
                                                    <%--Extra Charge DIM. & WT.--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayRtoCharge"
                                                                Text=" Is Display RTO Charge" />
                                                        </div>
                                                    </div>
                                                    <%--RTO Charge--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayOfficeMamul"
                                                                Text=" Is Display Office Mamul" />
                                                        </div>
                                                    </div>
                                                    <%--Office Mamul--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayotherExpense"
                                                                Text=" Is Display Other Expenses" />
                                                        </div>
                                                    </div>
                                                    <%--Office Expenses--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_TDSCharge"
                                                                Text=" Is Display TDS Charge" />
                                                        </div>
                                                    </div>
                                                    <%--TDS Charge--%>
                                                    <div class="form_grid">
                                                        <div class="form_lab">
                                                        </div>
                                                        <div class="form_fill">
                                                            <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayContainerChargeinChallan"
                                                                Text=" Is Display Container Charge" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Pickup Run Sheet Settings
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsPickupRunSheetAutoNo"
                                                    Text=" Is Pickup Run Sheet Auto No." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList runat="server" ID="dd_PRSWise" class="fill" Width="100%">
                                                    <asp:ListItem Value="0" Selected="True"> Unique Branch Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="1"> Is Pickup Run Sheet No. Unique Company Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="2"> Is Pickup Run Sheet No. Unique In System </asp:ListItem>
                                                    <asp:ListItem Value="3"> Is Pickup Run Sheet No. Unique Branch Wise </asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <%--22/11/2019--%>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisLedgerInPickUpRunSheet"
                                                    Text=" Is Display Ledger?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsDisPetrolPumpNameInPickupRunSheet"
                                                    Text=" Is Display Petrol Pump Name In Pickup Run Sheet ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsDisDieselQtyInPickupRunSheet"
                                                    Text=" Is Display Diesel Quantity In Pickup Run Sheet ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredDriverMobileNoPRS"
                                                    Text=" Is Required Driver Mobile No In Pickup Run Sheet ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisBrokerInPRS"
                                                    Text=" Is Display Broker Name ?" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsReqBrokerInPRS"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispOverloadChargeInPRS"
                                                    Text=" Is Display Overload Charge in PRS ?" />

                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisConsolidatedEWayBillNoInPrs" Text=" Is Display Consolidated E-Way Bill No ?" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_right">
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsPRSAutoNoDisable"
                                                    Text=" Is Pickup Run Sheet No Disable" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsPRSNoSeriesWise"
                                                    Text=" Is Pickup Run Sheet No. Series Wise" />
                                            </div>
                                        </div>
                                        <%--22/11/2019--%>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoAdvanceInPickUpRunSheet"
                                                    Text=" Is Auto Advance Entry In Cash OR Bank?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsDisDieselAmtInPickupRunSheet"
                                                    Text=" Is Display Diesel Amount In Pickup Run Sheet ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsAutoDieselEntryInPickupRunSheet"
                                                    Text=" Is Auto Diesel Entry In Pickup Run Sheet ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCardPumpinPickup"
                                                    Text=" Is Display Pump Card in Pickup Run Sheet?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisAgentInPRS"
                                                    Text=" Is Display Agent Name ?" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsReqAgentInPRS"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredCarrierTypeInPRS"
                                                    Text=" Is Required Carrier Type in Pickup Run Sheet ?" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Internal Challan Settings
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsIntChallanAutoNo"
                                                    Text=" Is Internal Challan Auto No." />
                                            </div>
                                        </div>
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList runat="server" ID="dd_ITCWise" class="fill" Width="100%">
                                                    <asp:ListItem Value="0" Selected="True"> Unique Branch Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="1"> Is Internal Challan No. Unique Company Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="2"> Is Internal Challan No. Unique In System </asp:ListItem>
                                                    <asp:ListItem Value="3"> Is Internal Challan No. Unique Branch Wise </asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsInternalChlBasedOnDelPaid"
                                                    Text=" Is Internal Challan Based On Delivery Paid ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisLedgerInIntChallan"
                                                    Text=" Is Display Ledger?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsDisPetrolPumpNameInInternalChallan"
                                                    Text=" Is Display Petrol Pump Name In Internal Challan ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsDisDieselQtyInInternalChallan"
                                                    Text=" Is Display Diesel Quantity In Internal Challan ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCardPumpinInternal"
                                                    Text=" Is Display Pump Card in Internal Challan Entry ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisAgentInITC"
                                                    Text=" Is Display Agent Name ?" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsReqAgentInITC"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisConsolidatedEWayBillNoInItc" Text=" Is Display Consolidated E-Way Bill No ?" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_right">
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsITCAutoNoDisable"
                                                    Text=" Is Internal Challan No Disable" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsITCNoSeriesWise"
                                                    Text=" Is Internal Challan No. Series Wise" />
                                            </div>
                                        </div>
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendMailInternalChallan"
                                                    Text=" Is Send Mail On Create Internal Challan ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsOwnNameRequiredInternalChallan"
                                                    Text=" Is Owner Name Required In Internal Challan ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoAdvanceInInternalChallan"
                                                    Text=" Is Auto Advance Entry In Cash OR Bank?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsDisDieselAmtInInternalChallan"
                                                    Text=" Is Display Diesel Amount In Internal Challan ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsAutoDieselEntryInInternalChallan"
                                                    Text=" Is Auto Diesel Entry In Internal Challan ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsInternalChallanBaseOnRecieptConf"
                                                    Text=" Is Internal Challan base on Reciept Confirmation?" />
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Hire Payment Advice Setting
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_AllowOtherChlInHpa"
                                                    Text=" Allow Other Challan In Hire Pay Advice" />
                                            </div>
                                        </div>
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList runat="server" ID="dd_HPAWise" class="fill" Width="100%">
                                                    <asp:ListItem Value="0" Selected="True"> Unique Branch Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="1"> Is Hire Payment Advice No. Unique Company Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="2"> Is Hire Payment Advice No. Unique In System </asp:ListItem>
                                                    <asp:ListItem Value="3"> Is Hire Payment Advice No. Unique Branch Wise </asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HPA_IsDispLessDeduction"
                                                    Text=" Is Display Less Deduction" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HPA_IsDispLoadingCharge"
                                                    Text=" Is Display Loading Charge" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HPA_IsDispOtherCharge"
                                                    Text=" Is Display Other Charge" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HPA_IsDispAdvanceAmount"
                                                    Text=" Is Display Advance Amount" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HPA_IsDispClaimCharge"
                                                    Text=" Is Display Claim Charge" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HPA_IsDispLetDelivery"
                                                    Text=" Is Display Let Delivery Charge" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HPA_IsDispBalPayment"
                                                    Text=" Is Display Bal. Payment Charge" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisDeliveryChargeInHpa"
                                                    Text=" Is Display Delivery Charge In Hpa ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisVehicleNoInHpa"
                                                    Text=" Is Display Vehicle No. In Hpa ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayVaraiInHpa"
                                                    Text=" Is Display Varai IN HPA" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayIncentiveInHpa"
                                                    Text=" Is Display Incentive IN HPA" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsHpaDieselQuantity"
                                                    Text=" Is Display DieselQuantity In HPA?" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredDieselQtyInHPA" Text=" Is Required" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDispStartKMHPA"
                                                    Text=" Is Display Start KM In HPA ?" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredStartKMInHPA" Text=" Is Required" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAllowSMSToVendorForHPA"
                                                    Text=" Allow SMS To Vendor ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayLedgerNameinHPA"
                                                    Text=" Is Display Ledger Name in HPA ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayExtraPointChargeInHPA"
                                                    Text=" Is Display Extra Point Charge in HPA ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayTollChargeInHPA"
                                                    Text=" Is Display Toll Charge in HPA ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayGreenTaxChargeInHPA"
                                                    Text=" Is Display Green Tax Charge in HPA ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsReceiptConfBaseOnHPA"
                                                    Text=" Is Reciept Confirmation base on HPA ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Rate Type
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList ID="ddl_RateTypeHpa" Width="53%" runat="server" CssClass="fill">
                                                    <asp:ListItem Text="Fix" Value="3" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="Bag" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="Ton" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Number" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="pkg" Value="5"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_right">
                                        <div class="form_grid" style="padding-top: 8px;">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsHpaAutoNo"
                                                    Text=" Is Hire Payment Advice Auto No." />
                                            </div>
                                        </div>
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsHPAAutoNoDisable"
                                                    Text=" Is Hire Payment Advice No Disable" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsHPANoSeriesWise"
                                                    Text=" Is Hire Payment Advice No. Series Wise" />
                                            </div>
                                        </div>
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HPA_IsDispContainerStationery"
                                                    Text=" Is Display Container Stationery" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HPA_IsDispMiscIncome"
                                                    Text=" Is Display Miscellaneous Income" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HPA_IsDispALHInterest"
                                                    Text=" Is Display ALH Interest" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HPA_IsDispDetantionCharge"
                                                    Text=" Is Display Detantion Charge" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HPA_IsDispHireCharge"
                                                    Text=" Is Display Hire Charge" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HPA_IsDispUnloadingCharge"
                                                    Text=" Is Display Unloading Charge" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_HPA_IsDispTDSCharge"
                                                    Text=" Is Display TDS Charge" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisToBranchNameInHpa"
                                                    Text=" Is Display To BranchName IN HPA" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayTCChargeInHpa"
                                                    Text=" Is Display T.C Charge IN HPA" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayThapiInHpa"
                                                    Text=" Is Display Thapi IN HPA" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoEntryofAdvance"
                                                    Text=" Is Auto Entry of Advance in CashBook" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsHpaDisplayPPName"
                                                    Text=" Is Display Petrol Pump Name ?" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredPumpNameInHPA" Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDispDieselAmountHPA"
                                                    Text=" Is Display Diesel Amount In HPA?" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredDieselAmtInHPA" Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoEntryDieselHpa"
                                                    Text=" Is Auto Entry Diesel HPA." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCashByPumpInHpa"
                                                    Text=" Is Display Cash By Pump in HPA ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayHeightChargeInHpa"
                                                    Text=" Is Display Height Charge in HPA ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayOverloadChargeInHpa"
                                                    Text=" Is Display Overload Charge in HPA ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCardPumpinHPA"
                                                    Text=" Is Display Pump Card in HPA ?" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--Added On 21/10/2016 By Ravi Ajugiya START--%>
                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Crossing Memo Setting
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <%--Added On 15/08/2016 By Ravi Ajugiya START--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" onclick="IsCrossingMemoDisable(this.checked);" ID="Ch_IsCrossingMemoAutoNo"
                                                    Text=" Is Crossing Memo Auto No." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDispDriverNameInCrossingMemo"
                                                    Text=" Is Display Driver Name." />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsReqDriverNameInCrossingMemo" Text=" Is Required" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispDriverMobileNoInCrossingMemo"
                                                    Text=" Is Display Driver Mobile No." />
                                            </div>
                                        </div>
                                        <%--Added On 15/08/2016 By Ravi Ajugiya END--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsReqVehicleNoInCrossingMemo" Text=" Is Required Vehicle No" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList runat="server" ID="dd_CrossingMemoWise" class="fill" Width="100%">
                                                    <asp:ListItem Value="0" Selected="True"> Unique Branch Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="1"> Is Crossing Memo No. Unique Company Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="2"> Is Crossing Memo No. Unique In System </asp:ListItem>
                                                    <asp:ListItem Value="3"> Is Crossing Memo No. Unique Branch Wise </asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_right">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayLorryHire"
                                                    Text=" Is Display Lorry Hire" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispLicenseNoInCrossingMemo"
                                                    Text=" Is Display Licence No." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDispOwnerNameinCrossingMemo"
                                                    Text=" Is Display Owner Name & Pan No" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsReqOwnerNameinCrossingMemo" Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisConsolidatedEWayBillNoInCrm" Text=" Is Display Consolidated E-Way Bill No ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid" id="dv_IsCrossingDisable" runat="server" style="display: none">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsCrossingNoDisable"
                                                    Text=" Is Crossing Auto No Disable" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%--Added On 21/10/2016 By Ravi Ajugiya END--%>

                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Local Driver Delivery Setting
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_IsDriverDeliveryAutoNo"
                                                    Text=" Is Driver Delivery Auto No." />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList runat="server" ID="dd_DRSWise" class="fill" Width="100%">
                                                    <asp:ListItem Value="0" Selected="True"> Unique Branch Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="1"> Is Driver Delivery No. Unique Company Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="2"> Is Driver Delivery No. Unique In System </asp:ListItem>
                                                    <asp:ListItem Value="3"> Is Driver Delivery No. Unique Branch Wise </asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <%--22/11/2019--%>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDriverAmtBaseonDP"
                                                    Text=" Is Driver Amount Base On Delivery Paid" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayMRAmtInPrint"
                                                    Text=" Is Display MR Amount In Print ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill margin2per width67box" ID="cb_IsLocalDriDelBasedOnReceiptConf" onclick="IsDisplayDDMDays(this.checked);"
                                                    Text=" Is DDM Based On Receipt Confi. ?" />

                                                <asp:TextBox ID="tb_DDMDays" Style="font-size: Small; width: 80px;" runat="server" CssClass="filltxtbox" MaxLength="3"
                                                    Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill margin2per width67box" ID="cb_IsLocalDriDelBasedOnDACC"
                                                    Text=" Is DDM Based On DACC . ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Default LR Show In Grid
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_DefaultLRRowsDDM" Style="font-size: Small; width: 100px;" runat="server" CssClass="fill" MaxLength="3"
                                                    Font-Size="Small" onkeypress="return Numeric(event);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill margin2per width67box" ID="cb_IsDisplayLDDStartKM"
                                                    Text=" Is Display Start kilometer ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill margin2per width67box" ID="cb_IsDisplayLDDHelperName"
                                                    Text=" Is Display Helper Name ?" />
                                            </div>
                                        </div>

                                        <%-- Dt:18-03-2019 --%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoAdvanceEntryInLDD"
                                                    Text=" Is Auto Advance Entry In Cash OR Bank?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoDieselEntryInLDD"
                                                    Text=" Is Auto Diesel Entry In Local Driver Delivery ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsDisDieselAmtInLDD"
                                                    Text=" Is Display Diesel Amount In Local Driver Delivery ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCardPumpinDRS"
                                                    Text=" Is Display Pump Card in Local Driver Delivery ?" />
                                            </div>
                                        </div>
                                        <%-- End Dt:18-03-2019 --%>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisAgentInDRS"
                                                    Text=" Is Display Agent Name ?" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsReqAgentInDRS"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisConsolidatedEWayBillNoInDRS"
                                                    Text=" Is Display Consolidated E-Way Bill No ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsOnlyDoorDeliveryLrAllowInDRS" Text=" Is Only Door Delivery Lr Allow In DRS/Local Driver Delivery ?" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_right">
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsDRSAutoNoDisable"
                                                    Text=" Is Local Driver Delivery No Disable" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsDRSNoSeriesWise"
                                                    Text=" Is Local Driver Delivery No. Series Wise" />
                                            </div>
                                        </div>
                                        <%--22/11/2019--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsLocalDriDelBasedOnDeliveryPaid"
                                                    Text=" Is Local Driver Delivery Based On Delivery Paid ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsCheckLRReceivedbyDefaultInDRS"
                                                    Text=" Is LR Received by default tick?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsLrReceivedChangeByAdminInDRS"
                                                    Text=" Is LR Received Changed By AdminUser?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisAutoDeliveryInLocalDriverDel"
                                                    Text=" Is Display Auto Delivery In Local Driver Delivery" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsEnterTheStatusForDDM"
                                                    Text=" Is Enter The Status For DDM" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayLDDEndKM"
                                                    Text=" Is Display End kilometer ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisplayLDDLastStation"
                                                    Text=" Is Display Last Station ?" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredLDDLastStation"
                                                    Text=" Is Required" />
                                            </div>
                                        </div>
                                        <%-- Dt:18-03-2019 --%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisPetrolPumpNameInLDD"
                                                    Text=" Is Display Petrol Pump Name In Local Driver Delivery ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisDieselQtyInLDD"
                                                    Text=" Is Display Diesel Quantity In Local Driver Delivery ?" />
                                            </div>
                                        </div>
                                        <%-- End Dt:18-03-2019 --%>
                                        <%-- <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisContractTypeInLDD"
                                                    Text=" Is Display Contract Type And Carrier Type In Local Driver Delivery ?" />
                                            </div>
                                        </div>--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width63box" ID="cb_IsDisContractTypeInLDD"
                                                    Text="Is Display Contract Type And Carrier Type In Local Driver Delivery ?" />
                                                &nbsp; &nbsp;
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width25per b_float" ID="cb_IsRequiredCarrierTypeInDD"
                                                    Text=" Is Required Carrier Type" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayBrokerNameinLocalDelivery"
                                                    Text=" Is Display Broker Name In Local Driver Delivery ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayFromStationInDRS"
                                                    Text="Is Display From Station In Local Driver Delivery ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendSmsToDriver"
                                                    Text=" Is Send Sms To Driver ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDriverMobileNoCompulsuryInDRS"
                                                    Text=" Is Driver Mobile Number Required ?" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Vehicle On Rent(Purchase) Setting
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_IsVehOnRentPurAutoNo"
                                                    Text=" Is Vehicle On Rent(Purchase) Auto No." />
                                            </div>
                                        </div>

                                    </div>
                                    <div class="form_right">

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList runat="server" ID="dd_VehOnRentPurAutoNoType" class="fill" Width="100%">
                                                    <asp:ListItem Value="0"> Unique Branch Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="1"> Is Challan No. Unique Company Wise (Financial Year)</asp:ListItem>
                                                    <asp:ListItem Value="2"> Is Challan No. Unique In System </asp:ListItem>
                                                    <asp:ListItem Value="3"> Is Challan No. Unique Branch Wise </asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- Diesel In And Out Setting--%>
                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Diesel In And Out Setting
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoPurchaseInDiesel"
                                                    Text=" Is Diesel Auto Purchase Entry" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendEmailinDieselIn"
                                                    Text=" Send Email in Diesel In" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayDieselOutLoadingPoint"
                                                    Text="Is Display Loading Point ?" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_right">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendSMSinDieselIn"
                                                    Text=" Send SMS in Diesel In" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCardPumpinDieselIn"
                                                    Text=" Is Display Pump Card in Diesel In" />
                                            </div>
                                        </div>
                                    </div>


                                </div>
                            </div>
                        </div>

                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Goods Receipt Note Setting
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayImportSerialFile"
                                                    Text=" Is Display Import Serial No File" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplaySerialNoInGrn"
                                                    Text=" Is Display Serial No" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_right">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayLrNoANDLrDate"
                                                    Text=" Is Display Lr No and Lr Date" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayExpiryDate"
                                                    Text="Is Display Expiry Date" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Order Management Setting
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendSMSToBilledOn"
                                                    Text=" Is Send SMS To Billed On" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoGenerateOrderMgnt"
                                                    Text=" Is Auto Generate Order Management" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoGenerateIndentMgnt"
                                                    Text=" Is Auto Generate Indent Management" />
                                            </div>
                                        </div>
                                        <%--Add by Sanjay Dt-25/08/2017 --%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Type : 
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList ID="ddl_Type" Width="47%" runat="server" CssClass="fill">
                                                    <asp:ListItem Text=" General" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text=" Machine Wise" Value="1"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayOrderTypeInOrderMgnt"
                                                    Text=" Is Display Order Type In Order Management" />
                                            </div>
                                        </div>
                                        <%--End--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendEmailForOrderMgmt"
                                                    Text=" Is Send Email To Billed On/ Consignor/ Consignee" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayOrderExpiryDate"
                                                    Text=" Is Display Order Expiry Date" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayOrderPromptDate"
                                                    Text=" Is Display Order Prompt Date" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayRequirementType"
                                                    Text=" Is Display Requirement Type" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCarrierTypeInIndentMngt"
                                                    Text=" Is Display Carrier Type in Indent Management" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_right">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendSmsToBillonIndent"
                                                    Text=" Is Send SMS To Billed On In Indent Mgnt" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAutoGeneratePicklist"
                                                    Text=" Is Auto Generate Pick List" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsRequiredConsignorConsigneeInOrderManagement"
                                                    Text=" Is Required Consignor & Consignee In Order Management" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsCustLoginConrConAutocompleteInOrderManagment"
                                                    Text=" Is Customer Login Consignor & Consignee Autocomplete In Order Management" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSendEmailForIndentMgmt"
                                                    Text=" Is Send Email To Billed On/ Consignor/ Consignee in Indent Mgmt" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayOrderCarrierType"
                                                    Text=" Is Display Carrier Type" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayOrderExpectedDate"
                                                    Text=" Is Display Order Expected Date" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayOrderTransistDays"
                                                    Text=" Is Display Transist Days" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Report Setting
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayMiroDocNoInReport"
                                                    Text=" Is Display Miro Doc No In Approved by Auditor Report" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispLRToBrnRecWiseInReport"
                                                    Text=" Is Display LR To Branch Receipt Wise In Approved by Auditor Report" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsReqPodFileInReport"
                                                    Text=" Is Required Pod File In Approved By Auditor Report" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_right">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayFIVoucherNoInReport"
                                                    Text=" Is Display FI Voucher No In Aproved by Auditor Report" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsFromBranchRightsWiseForReport"
                                                    Text=" Is From Branch Rights Wise In Aproved by Auditor Report" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Invoice Setting
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:DropDownList runat="server" ID="dd_InvoiceNoPattern" CssClass="fill" Width="100%">
                                                    <asp:ListItem Value="0">Unique Invoice No</asp:ListItem>
                                                    <asp:ListItem Value="1">Duplicate Invoice No</asp:ListItem>
                                                    <asp:ListItem Value="2">All Duplicate Invoice No</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_VehNoDisplayInBill"
                                                    Text=" Is Veh No. Display In Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_MachineQtyDisplayInBill"
                                                    Text=" Is Machine Qty. Display In Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_PackageDisplayInBill"
                                                    Text=" Is Package Display In Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_WeightDisplayInBill"
                                                    Text=" Is Weight Display In Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_Isdisplayadvanceinbill"
                                                    Text=" Is Display Advance In Bill" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_FromStation"
                                                    Text=" Is Display From Station In Bill" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayBiltyRemarkinBillPrint"
                                                    Text=" Is Display Bilty Remark in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsTaxDisplay"
                                                    Text=" Is Allow Notification Tax Display In Bill" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayPrefixInBill"
                                                    Text=" Is Display Prefix In Bill" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisPartyInvoiceNo"
                                                    Text=" Is Display Party Invoice No In Bill" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsBillPrintPanNoandServiceTaxNo"
                                                    Text=" Invoice LetterHead with Pan No. & Service Tax No." />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsVericalChargesInvoice"
                                                    Text="Is Charges Vertical in Invoice Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayReferenceNo"
                                                    Text="Is Display Reference No. in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayJobNo"
                                                    Text="Is Display Booking No./Job No. in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplaySealNo"
                                                    Text="Is Display Seal No. in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayBENo"
                                                    Text="Is Display BE No. in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayServiceEntryNo"
                                                    Text="Is Display Service Entry No. in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsHideVerticalCharges"
                                                    Text="Is Hide Vertical Charges in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayDeliveryDate"
                                                    Text="Is Display Delivery Date in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayMiroDocNoInBill"
                                                    Text="Is Display Miro Doc No. in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayShipmentCostNoInBill"
                                                    Text="Is Display Shipment Cost No. in Bill Print" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayConsignorAddInBill"
                                                    Text="Is Display Consignor Address in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayConsigneeAddInBill"
                                                    Text="Is Display Consignee Address in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayPrivateMarkInBill"
                                                    Text="Is Display Private Mark in Bill Print" />
                                            </div>
                                        </div>


                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayReceivedTime"
                                                    Text="Is Display Received Time in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayTransitDate"
                                                    Text="Is Display Transit Date in Bill Print" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayLRNo"
                                                    Text="Is Display LR No. in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCubicFeetInBillPrint"
                                                    Text=" Is Display Cubic Feet in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayChargableDays"
                                                    Text=" Is Display Chargeable Days" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayNoofExtraPointinBillPrint"
                                                    Text=" Is Display No. of Extra Point in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayDistrictinBillPrint"
                                                    Text=" Is Display District in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayTalukainBillPrint"
                                                    Text=" Is Display Taluka in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSeqMaintainInvoiceDtBase"
                                                    Text=" Is Sequence Maintain Invoice Date Base" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispalyFromBranchInBill"
                                                    Text=" Is Display From Branch in Bill" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayMaterialTypeInBill"
                                                    Text=" Is Display Material Type in Bill" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayDeliveryTypeInBill"
                                                    Text=" Is Display Delivery Type in Bill Print ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayGWeightInBill"
                                                    Text="Is Display Gross Weight in Bill Print " />
                                            </div>
                                        </div>
                                        <%--GrossWt--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayTWeightInBill"
                                                    Text="Is Display Tare Weight in Bill Print " />
                                            </div>
                                        </div>
                                        <%--TareWt--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayActualCMTInBill"
                                                    Text="Is Display Actual CMT in Bill Print " />
                                            </div>
                                        </div>
                                        <%--Actual Cubic Meter--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayRateTypeInBillPrint"
                                                    Text="Is Display Rate Type in Bill Print " />
                                            </div>
                                        </div>
                                        <%--Rate Type--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsGenerateBillDependsOnProfit"
                                                    Text="Is Generate Bill Depends On Profit " />
                                            </div>
                                        </div>
                                        <%--GenerateBill Depends On Profit--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisHSNCode"
                                                    Text="Is Display HSN Code in Bill Print" />
                                            </div>
                                        </div>
                                        <%--HSN Code--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisBranchNameInInvoice"
                                                    Text="Is Display BranchName in Bill Print" />
                                            </div>
                                        </div>
                                        <%--Branch Name--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayPeriodInInvoice"
                                                    Text="Is Display Period in Bill Print" />
                                            </div>
                                        </div>
                                        <%--Period--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayFreightInVerticalFormatInBillPrint"
                                                    Text="Is Display Freight in Vertical Format in Bill Print" />
                                            </div>
                                        </div>
                                        <%--Freight in Verticle format--%>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IsSendSMSinGenerateBill" Text=" Is Send SMS in Generate Bill ?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="Cb_IdDisplayDeliveryPaidDateInBill" Text=" Is Display Delivery Paid Date in Bill Print" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisDistanceinBillPrint" Text=" Is Display Distance in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayKotNoInBill" Text=" Is Display KOT No. in Bill?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayBillingDocketNoinBill" Text=" Is Display Billing Docket No. in Bill?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayBillingDocketDateinBill" Text=" Is Display Billing Docket Date in Bill?" />
                                            </div>
                                        </div>

                                    </div>
                                    <div class="form_right">
                                        <div class="form_grid">
                                            <div class="form_fill">
                                                <asp:Label ID="l_RoadSC" runat="server" CssClass="form_lab" Style="width: 33%;">Road Service Code
                                                </asp:Label>
                                                <asp:TextBox runat="server" ID="tb_RoadServiceCode" CssClass="fill" Width="60%" Text="" Style="float: right">                                                    
                                                </asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_fill">
                                                <asp:Label ID="l_TrainSC" runat="server" CssClass="form_lab" Style="width: 33%;">Train Service Code
                                                </asp:Label>
                                                <asp:TextBox runat="server" ID="tb_TrainServiceCode" CssClass="fill" Width="60%" Text="" Style="float: right">                                                    
                                                </asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_fill">
                                                <asp:Label ID="l_AirSC" runat="server" CssClass="form_lab" Style="width: 33%;">Air Service Code
                                                </asp:Label>
                                                <asp:TextBox runat="server" ID="tb_AirServiceCode" CssClass="fill" Width="60%" Text="" Style="float: right">                                                    
                                                </asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_fill">
                                                <asp:Label ID="l_SeaSC" runat="server" CssClass="form_lab" Style="width: 33%;">Sea Service Code</asp:Label>
                                                <asp:TextBox runat="server" ID="tb_SeaServiceCode" CssClass="fill" Width="60%" Text="" Style="float: right"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_fill">
                                                <asp:Label ID="l_GbillPrefix" runat="server" CssClass="form_lab" Style="width: 33%;">Paid-Credit Bill Prefix
                                                </asp:Label>
                                                <asp:TextBox runat="server" ID="tb_GBillPrefix" CssClass="fill" Width="60%" Text="" Style="float: right">                                                    
                                                </asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_ConsignorDisplayInBill"
                                                    Text=" Is Consignor Display In Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_ConsigneeDisplayInBill"
                                                    Text=" Is Consignee Display In Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_RateDisplayInBill"
                                                    Text=" Is Rate Display In Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="ch_AutoNoDisplayInBill"
                                                    Text=" Is Auto No(Micr No.) Display In Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_Particulars"
                                                    Text=" Is Display Particulars In Bill" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_ToStation"
                                                    Text=" Is Display To Station In Bill" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width50per" ID="cb_IsDisInvoiceNo" Text=" Is Display Invoice No In Bill" />
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill width40per" ID="cb_IsInvoiceNoDisable" Text=" Is Invoice No Disable" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayBranchCode"
                                                    Text=" Is Display Branch Code In Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsSerTaxRoundOffInBill"
                                                    Text=" Is Service Tax Round Off In Bill" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisKmInBill"
                                                    Text=" Is Display Km In Bill" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisActualWeightInBill"
                                                    Text=" Is Display Actual Weight In Bill" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisCarrierTypeInBill"
                                                    Text=" Is Display Carrier Type In Bill" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayShipmentNo"
                                                    Text="Is Display Shipment No. in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayMaterialName"
                                                    Text="Is Display Material Name in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayContainerNo"
                                                    Text="Is Display Container No. in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayPurchaseNo"
                                                    Text="Is Display Purchase No. in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisUnloadingDate"
                                                    Text="Is Display Unloading Date in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayReceiptDate"
                                                    Text="Is Display Receipt Date in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayReceivedDateInBillPrint"
                                                    Text="Is Display Received Date in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_DisplayFiVoucherNoInBill"
                                                    Text="Is Display FI Voucher No. in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayPackageTypeInBill"
                                                    Text="Is Display Package Type in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayConsignorGSTNoInBill"
                                                    Text="Is Display Consignor GST No. in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayConsigneeGSTNoInBill"
                                                    Text="Is Display Consignee GST No. in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayConPrivateMarkInBill"
                                                    Text="Is Display Continuous Private Mark in Bill Print" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayUnloadingTime"
                                                    Text="Is Display Unloading Time in Bill Print" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayPlacedAtDate"
                                                    Text="Is Display Placed At Date in Bill Print" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayPartyInvoiceDate"
                                                    Text="Is Display Party Invoice Date in Bill Print" />
                                            </div>
                                        </div>


                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayExtraCubicFeetInBillPrint"
                                                    Text=" Is Display Extra Cubic Feet in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayDeliverOrderNoinBillPrint"
                                                    Text=" Is Display Delivery Rec. / Ord. No. in Bill Print" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayChargeWtMT"
                                                    Text=" Is Display Charge Weight (M.T) in Bill Print ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayActualWtMT"
                                                    Text=" Is Display Actual Weight (M.T) in Bill Print ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCustLRNoInBillPrint"
                                                    Text=" Is Display Customer LR No in Bill Print ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayChargeUpToInBill"
                                                    Text=" Is Display Charge Up To in Bill Print ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayEWayBillNoInBill"
                                                    Text=" Is Display E-Way Bill No in Bill Print ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayAdvanceInBill"
                                                    Text=" Is Display Advance in Bill Print ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayCubicMeterInBill"
                                                    Text=" Is Display Cubic Meter in Bill Print" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsGenerateBillDependsOnPOD"
                                                    Text=" Is Generate Bill Depends On POD" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsGenerateBillDependsOnChallanEntry"
                                                    Text=" Is Generate Bill Depends On Challan\Crossing Entry" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                Invoice Print
                                            </div>
                                            <div class="form_fill">
                                                <asp:RadioButtonList Visible="true" RepeatColumns="3" ID="rbl_InvoicePrint" Width="100%" runat="server"
                                                    RepeatDirection="Horizontal" CssClass="margn_l10 margn_r10 font14_blue fill1">
                                                    <asp:ListItem Text=" Default" Selected="True" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text=" Paper Print" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text=" Letter Print" Value="2"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAllowAfterPayment"
                                                    Text=" Is Allowed Changes in Genrate Bill after Payment Done" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispalyCustTitleInBill"
                                                    Text=" Is Display Customer Title in Invoice" />
                                            </div>
                                        </div>
                                        <%--31/03/2020--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDispalyMIRODocNoInBill"
                                                    Text=" Is Display MIRO Doc No. in Bill" />
                                            </div>
                                        </div>
                                        <%--31/03/2020--%>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayReverseChargeinBill" Text=" Is Display Reverse Charge in Bill" Style="width: 60%" />

                                                <asp:DropDownList ID="dd_ReverseCharge" Width="32%" runat="server" CssClass="fill b_float" Style="padding: 1.7%; display: none;">
                                                    <asp:ListItem Selected="True" Value="0" Text="--Select--"></asp:ListItem>
                                                    <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                                                    <asp:ListItem Value="2" Text="No"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayStoNoInBill" Text=" Is Display STO No. in Bill?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayGanNoInBill" Text=" Is Display GAN No. in Bill?" />
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayPODateinBill" Text=" Is Display PO Date in Bill?" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            ToPay Bill Setting
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillDoorDeliveryChg"
                                                    Text=" Is Display Door Delivery Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillServiceChg"
                                                    Text=" Is Display Service Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillOctroiServChg"
                                                    Text=" Is Display Octroi Serv. Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillGInsuranceChg"
                                                    Text=" Is Display G Insurance Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillServiceTaxChg"
                                                    Text=" Is Display Service Tax Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillCGSTChg"
                                                    Text=" Is Display CGST Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillCessTaxChg"
                                                    Text=" Is Display Cess Tax Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillPrivateMark"
                                                    Text=" Is Display Private Mark ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillDeliveryPkgs"
                                                    Text=" Is Display Delivery Pkgs ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillTotalCharge"
                                                    Text=" Is Display Total Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillLrRate"
                                                    Text=" Is Display Rate ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillDocketCharge"
                                                    Text=" Is Display Docket Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillContains"
                                                    Text=" Is Display Contains ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayInvoiceValueInToPayBill"
                                                    Text=" Is Display Invoice Value ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SettTPBillLrActualWeight"
                                                    Text=" Is Display Lr Actual Weight ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisplayMrDate"
                                                    Text=" Is Display Mr Date ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SettIsDisplayVehicleNo"
                                                    Text=" Is Display Vehicle No ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SettIsDisplayTollTaxCharge"
                                                    Text=" Is Display TollTax Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SettIsDisplayContainWiseTotalPkgs"
                                                    Text=" Is Display Contain Wise Total Pkgs ?" />
                                            </div>
                                        </div>
                                    </div>
                                    <%--Right--%>
                                    <div class="form_right">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillHamaliChg"
                                                    Text=" Is Display Hamali Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillOtherChg"
                                                    Text=" Is Display Other Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillDemmurageChg"
                                                    Text=" Is Display Demurrage Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillPollutionChg"
                                                    Text=" Is Display Pollution Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillSGSTChg"
                                                    Text=" Is Display SGST Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillIGSTChg"
                                                    Text=" Is Display IGST Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillConsignee"
                                                    Text=" Is Display Consignee ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillInvoiceNo"
                                                    Text=" Is Display Invoice No. ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillWeight"
                                                    Text=" Is Display Weight ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillConsignor"
                                                    Text=" Is Display Consignor ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillMrNo"
                                                    Text=" Is Display Mr No ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SetTPBillPackageType"
                                                    Text=" Is Display Package Type ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SettTPBillCollectionCharge"
                                                    Text=" Is Display Collection Charge ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SettTPBillBasicLrFreight"
                                                    Text=" Is Display Basic Lr Freight ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SettTPBillLrChargeWeight"
                                                    Text=" Is Display Lr Charge Weight ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SettIsDisplayFromStation"
                                                    Text=" Is Display From Station ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SettIsDisplayToStation"
                                                    Text=" Is Display To Station ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SettIsDisplayLrFreight"
                                                    Text=" Is Display Lr Freight ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_SettIsDisplayFromBranchGSTNo"
                                                    Text=" Is Display From Branch GST No ?" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            Invoice Details
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="chek_listing">
                                <div class="form_left" style="width: 45%;">
                                    <div class="form_grid" style="width: 100%;">
                                        <div class="form_lab">
                                            Terms and Conditions :
                                        </div>
                                        <div class="form_fill">
                                            <asp:TextBox ID="tb_termsAndCondition" runat="server" CssClass="fill_txt" Font-Size="Small"
                                                TextMode="MultiLine" Width="410px" Height="80"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modual_main">
                            <div class="inner_modual">
                                <div class="mdl_ttl">
                                    <div class="mdl_ttl_bg">
                                        <div class="mdl_txt">
                                            GST Setting
                                        </div>
                                    </div>
                                </div>
                                <div class="inner_crt">
                                    <div class="form_left">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsAllowGST"
                                                    Text=" Is Allow GST ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsDisableTaxPaidBy"
                                                    Text=" Is Disable Tax Paid By ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                SGST:
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_SGSTpercentage" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                    MaxLength="10" Font-Size="Small"></asp:TextBox>
                                                %
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                SGST For Train:
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_SGSTForTrainPer" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                    MaxLength="10" Font-Size="Small"></asp:TextBox>
                                                %
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                IGST For Train:
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_IGSTForTrainPer" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                    MaxLength="10" Font-Size="Small"></asp:TextBox>
                                                %
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                CGST For Air:
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_CGSTForAirPer" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                    MaxLength="10" Font-Size="Small"></asp:TextBox>
                                                %
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                IGST For Air:
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_IGSTForAirPer" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                    MaxLength="10" Font-Size="Small"></asp:TextBox>
                                                %
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                SGST For Sea:
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_SGSTForSeaPer" runat="server" Width="100px" CssClass="fillfloatnone numeric" MaxLength="10" Font-Size="Small"></asp:TextBox>%
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form_right">
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                &nbsp;
                                            </div>
                                            <div class="form_fill">
                                                <asp:CheckBox runat="server" Font-Bold="true" CssClass="fill" ID="cb_IsLREntryLockForGST"
                                                    Text=" Is LR Entry Lock for GST ?" />
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                GST Amount:
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_GstAmount" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                    MaxLength="10" Font-Size="Small"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                CGST:
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_CGSTpercentage" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                    MaxLength="10" Font-Size="Small"></asp:TextBox>
                                                %
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                IGST:
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_IGSTpercentage" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                    MaxLength="10" Font-Size="Small"></asp:TextBox>
                                                %
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                CGST For Train:
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_CGSTForTrainPer" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                    MaxLength="10" Font-Size="Small"></asp:TextBox>
                                                %
                                            </div>
                                        </div>

                                        <div class="form_grid">
                                            <div class="form_lab">
                                                SGST For Air:
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_SGSTForAirPer" runat="server" Width="100px" CssClass="fillfloatnone numeric"
                                                    MaxLength="10" Font-Size="Small"></asp:TextBox>
                                                %
                                            </div>
                                        </div>


                                        <div class="form_grid">
                                            <div class="form_lab">
                                                CGST For Sea:
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_CGSTForSeaPer" runat="server" Width="100px" CssClass="fillfloatnone numeric" MaxLength="10" Font-Size="Small"></asp:TextBox>%
                                            </div>
                                        </div>
                                        <div class="form_grid">
                                            <div class="form_lab">
                                                IGST For Sea:
                                            </div>
                                            <div class="form_fill">
                                                <asp:TextBox ID="tb_IGSTForSeaPer" runat="server" Width="100px" CssClass="fillfloatnone numeric" MaxLength="10" Font-Size="Small"></asp:TextBox>%
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                    <div class="right_part">
                        <div class="inner_crt">
                            <div class="form_left" style="width: 45%;">
                                <div class="form_grid">
                                    <div class="form_lab">
                                        User Limit Days For Transport Group:
                                    </div>
                                    <div class="form_fill">
                                        <asp:GridView ID="gv_BranchWiseTransportDay" HeaderStyle-HorizontalAlign="Center"
                                            runat="server" PagerSettings-Mode="Numeric" AutoGenerateColumns="false" CssClass="tabl_line"
                                            GridLines="None" AllowPaging="False" RowStyle-HorizontalAlign="Center" Width="100%">
                                            <RowStyle CssClass="odd_line" />
                                            <AlternatingRowStyle CssClass="evn_line" />
                                            <PagerStyle CssClass="paging_main" HorizontalAlign="Left" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Branch Name">
                                                    <HeaderStyle HorizontalAlign="center" CssClass="bdr_h" />
                                                    <ItemStyle CssClass="bdr_v" HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="l_BranchName" Text='<%# Eval("Cru_Name") %>'></asp:Label>
                                                        <asp:HiddenField runat="server" ID="hf_Brn_Id" Value='<%# Eval("Cru_Id") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="No. of Days">
                                                    <HeaderStyle HorizontalAlign="center" CssClass="bdr_h" />
                                                    <ItemStyle CssClass="bdr_v" HorizontalAlign="Right" />
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="tb_Days" CssClass="fill" Text="0">
                                                        </asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                            <div class="form_right" style="width: 45%;">
                                <div class="form_grid">
                                    <div class="form_lab">
                                        User Limit Days For Accounting Group:
                                    </div>
                                    <div class="form_fill">
                                        <asp:GridView ID="gv_BranchwiseAccountingDays" HeaderStyle-HorizontalAlign="Center"
                                            runat="server" PagerSettings-Mode="Numeric" AutoGenerateColumns="false" CssClass="tabl_line"
                                            GridLines="None" AllowPaging="False" RowStyle-HorizontalAlign="Center" Width="100%">
                                            <RowStyle CssClass="odd_line" />
                                            <AlternatingRowStyle CssClass="evn_line" />
                                            <PagerStyle CssClass="paging_main" HorizontalAlign="Left" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Branch Name">
                                                    <HeaderStyle HorizontalAlign="center" CssClass="bdr_h" />
                                                    <ItemStyle CssClass="bdr_v" HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="l_BranchName" Text='<%# Eval("Cru_Name") %>'></asp:Label>
                                                        <asp:HiddenField runat="server" ID="hf_Brn_Id" Value='<%# Eval("Cru_Id") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="No. of Days">
                                                    <HeaderStyle HorizontalAlign="center" CssClass="bdr_h" />
                                                    <ItemStyle CssClass="bdr_v" HorizontalAlign="Right" />
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="tb_Days" CssClass="fill" Text="0">
                                                        </asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="right_part">
                        <div class="form_grid">
                            <div class="form_lab">
                                &nbsp;
                            </div>
                            <div class="form_fill">
                                <div class="btn_comman">
                                    <asp:Button ID="b_Submit" runat="server" Text="Save" CssClass="btn" OnClientClick="return Setting();"
                                        OnClick="b_Submit_Click" />
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </form>
    </div>
</body>
</html>
