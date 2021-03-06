﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tool.aspx.cs" Inherits="SUOMI.Tool" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>




        <!--
		TITLES, FONTS, JQUERY IMPORT
		-->
        <title>SUOMI 🐧</title>

        <link href="https://fonts.googleapis.com/css?family=Montserrat|Open+Sans|Raleway&effect=3d" rel="stylesheet">
        <link rel="stylesheet" href="styles.css" type="text/css">
        <meta charset="utf-8" />
        <script language="javascript" type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js">
        </script>

        <!--
		FUNCTION: FROM HEADER TO HEADER.SMALLER
		-->
        <script>
            $(function () {
                $(window).scroll(function () {
                    var scroll = $(window).scrollTop();
                    if (scroll >= 100) {
                        $(".header").addClass('smaller');
                        $(".col1").addClass('smaller');
                        $(".col3").addClass('smaller');
                        $(".trigram").addClass('smaller');
                        $(".basketIcon").addClass('smaller');
                        $(".buynow").addClass('smaller');
                    } else {
                        $(".header").removeClass("smaller");
                        $(".col1").removeClass("smaller");
                        $(".col3").removeClass("smaller");
                        $(".trigram").removeClass('smaller');
                        $(".basketIcon").removeClass('smaller');
                        $(".buynow").removeClass('smaller');
                    }
                });
            });
        </script>

        <!-- 
        FUNCTION: DRAG & DROP
        -->
        <script>
            function off() {
                document.getElementById('overlay').style.opacity = 0;
                document.getElementById('overlay').style.visibility = "hidden";
            }

            function allowDrop(ev) {
                ev.preventDefault();
            }

            function drag(ev) {
                ev.dataTransfer.setData("text", ev.target.id);
                ev.dataTransfer.effectAllowed = 'copy';
            }

            function drop(ev) {
                ev.preventDefault();
                var data = ev.dataTransfer.getData("text");
                var oggetto = document.getElementById(data);

                sommatoria = document.getElementById("sommatoria");
                sommatoria.innerHTML = (parseFloat(sommatoria.innerHTML) + parseFloat(oggetto.dataset.prezzo)).toFixed(2);

                sommatoria_s = document.getElementById("sommatoriamobile");
                sommatoria_s.innerHTML = (parseFloat(sommatoria_s.innerHTML) + parseFloat(oggetto.dataset.prezzo)).toFixed(2);

                update = document.getElementById(data + "quantity");

                if (update) {
                    update.innerHTML = parseFloat(update.innerHTML) + 1;
                } else {
                    carrello = document.getElementById("dropzone");
                    carrello.innerHTML += "<tr id=\"" + oggetto.id + "row\"><td>" + oggetto.dataset.nome + "</td><td>x<output id=\"" + data + "quantity\">1</td><td>" + oggetto.dataset.prezzo + "</td><td><a id=\"" + oggetto.id + "rowremove\" href=\"#\" style=\"text-decoration: none\" onclick=\"removeAll(this,event)\">x</a> <a id=\"" + oggetto.id + "rowremove\" href=\"#\" style=\"text-decoration: none\"onclick=\"removeOne(this,event)\">-</a></td></tr>";
                }

                update_s = document.getElementById(data + "quantitymobile");

                if (update_s) {
                    update_s.innerHTML = parseFloat(update_s.innerHTML) + 1;
                } else {
                    carrello = document.getElementById("dropzonemobile");
                    carrello.innerHTML += "<tr id=\"" + oggetto.id + "rowmobile\"><td>" + oggetto.dataset.nome + "</td><td>x<output id=\"" + data + "quantitymobile\">1</td><td>" + oggetto.dataset.prezzo + "</td><td><a id=\"" + oggetto.id + "rowremovemobile\" href=\"#openCart\" style=\"text-decoration: none\" onclick=\"removeAll(this,event)\">x</a> <a id=\"" + oggetto.id + "rowremovemobile\" href=\"#openCart\" style=\"text-decoration: none\"onclick=\"removeOne(this,event)\">-</a></td></tr>";
                }
            }
        </script>

        <!--
        FUNCTION: CART DROP
        -->
        <script>
            function removeAll(row, ev) {
                if (!ev.target.id.includes("mobile")) {
                    objectID = ev.target.id.replace('rowremove', '');
                } else {
                    objectID = ev.target.id.replace('rowremovemobile', '');
                }

                oggetto = document.getElementById(objectID);
                quantity = document.getElementById(objectID + "quantity");
                quantity_s = document.getElementById(objectID + "quantitymobile");
                sommatoria = document.getElementById("sommatoria");
                sommatoria.innerHTML = (parseFloat(sommatoria.innerHTML) - parseFloat(oggetto.dataset.prezzo) * parseFloat(quantity.innerHTML)).toFixed(2);
                sommatoria_s = document.getElementById("sommatoriamobile");
                sommatoria_s.innerHTML = (parseFloat(sommatoria_s.innerHTML) - parseFloat(oggetto.dataset.prezzo) * parseFloat(quantity_s.innerHTML)).toFixed(2);

                var i = row.parentNode.parentNode.rowIndex;
                document.getElementById('dropzone').deleteRow(i);
                document.getElementById('dropzonemobile').deleteRow(i);
            }

            function removeOne(row, ev) {
                if (!ev.target.id.includes("mobile")) {
                    objectID = ev.target.id.replace('rowremove', '');
                } else {
                    objectID = ev.target.id.replace('rowremovemobile', '');
                }

                oggetto = document.getElementById(objectID);
                quantity = document.getElementById(objectID + "quantity");
                quantity_s = document.getElementById(objectID + "quantitymobile");
                sommatoria = document.getElementById("sommatoria");
                sommatoria.innerHTML = (parseFloat(sommatoria.innerHTML) - parseFloat(oggetto.dataset.prezzo)).toFixed(2);
                sommatoria_s = document.getElementById("sommatoriamobile");
                sommatoria_s.innerHTML = (parseFloat(sommatoria_s.innerHTML) - parseFloat(oggetto.dataset.prezzo)).toFixed(2);
                quantity.innerHTML = parseFloat(quantity.innerHTML) - 1;
                quantity_s.innerHTML = parseFloat(quantity_s.innerHTML) - 1;

                if (parseFloat(quantity.innerHTML) == 0) {
                    var i = row.parentNode.parentNode.rowIndex;
                    document.getElementById('dropzone').deleteRow(i);
                    document.getElementById('dropzonemobile').deleteRow(i);
                }
            }
        </script>
    </head>

    <body>
        <div id="overlay" onclick="off()">
            <br>
            Drag and drop to the cart!<br>
            <img src="img/white_arrow.png">
        </div>
        <!--
		SMARTPHONE SIDENAV
		-->
        <div id="mySidenav" class="sidenav">
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
            <h1>Filters</h1>


            <div class="bev">
                <label for="BevandeCheck">Spa</label>
                <input class="BevandeCheck" type="checkbox" name="BevandeCheck" value="1" checked />
            </div>

            <script>
                $(".BevandeCheck").click(function () {
                    if ($(this).is(":checked")) {
                        $(".BevandeCol").show();
                    } else {
                        $(".BevandeCol").hide();
                    }
                });
            </script>

            <div class="pas">
                <label for="PastaCheck">Pool</label>
                <input class="PastaCheck" type="checkbox" name="PastaCheck" value="1" checked/>
            </div>

            <script>
                $(".PastaCheck").click(function () {
                    if ($(this).is(":checked")) {
                        $(".PastaCol").show();
                    } else {
                        $(".PastaCol").hide();
                    }
                });
            </script>
        </div>

        <script>
            function openNav() {
                document.getElementById("mySidenav").style.width = "200px";
            }

            function closeNav() {
                document.getElementById("mySidenav").style.width = "0";
            }
        </script>

        <!--
		SMARTPHONE HEADER
		-->
        <div class="header">
            <div class="trigram" id="myTrigram">
                <input type="button" value="&#9776" onclick="openNav()" style="background-color: transparent; border-color: transparent; cursor: default; font-size: 30px; color: white;" />
            </div>

            <div class="font-effect-3d">
                <h1 id="logo">SUOMI 🐧</h1>
            </div>

            <div class="basketIcon" id="myBasketIcon" ondrop="drop(event)" ondragover="allowDrop(event)">
                <a href="#openCart">
                    <input type="image" src="img/shopping_cart.png" height="42" width="42" value="" onclick="showDiv()" style="background-color: transparent; border-color: transparent; cursor: default; font-size: 30px; color: white" /></a>
            </div>
            <div id="openCart" class="modalCart">
                <div>
                    <a href="#close" title="Close" class="close">X</a>
                    <h1>Cart</h1>
                    <table id="dropzonemobile" fitcolumns="true">
                        <tr>
                            <th width="140" align="left"><b>Nome</b></th>
                            <th width="60" align="left"><b>&#35;</b></th>
                            <th width="60" align="left"><b>€</b></th>
                        </tr>
                    </table>
                    <p>
                        <b>Total:</b> €
                        <output id="sommatoriamobile">0.00</output>
                    </p>
                    <p><i>Drop articles on the cart</i></p>
                </div>
            </div>

            <a href="#openModal" onclick="makeID();">
                <input class="buynow" type="image" src="img/paypal.png" onclick="makeID()" height="25px" width="80px" style="background-color: transparent; border-color: transparent; font-size: 30px;" /></a>

            <div id="openModal" class="modalDialog">
                <div>
                    <a href="#close" title="Close" class="close">X</a>
                    <h2>Payment completed!</h2>
                    <p>Thank you for enjoying SUOMI!</p>
                </div>
            </div>


        </div>

        <!--
		DESKTOP FILTERS
		-->
        <div class="col1">
            <h2>Filters</h2>

            <div class="bev">
                <label for="BevandeCheck">Spa</label>
                <input class="BevandeCheck" type="checkbox" name="BevandeCheck" value="1" checked/>
            </div>

            <script>
                $(".BevandeCheck").click(function () {
                    if ($(this).is(":checked")) {
                        $(".BevandeCol").show();
                    } else {
                        $(".BevandeCol").hide();
                    }
                });
            </script>

            <div class="pas">
                <label for="PastaCheck">Pool</label>
                <input class="PastaCheck" type="checkbox" name="PastaCheck" value="1" checked/>
            </div>

            <script>
                $(".PastaCheck").click(function () {
                    if ($(this).is(":checked")) {
                        $(".PastaCol").show();
                    } else {
                        $(".PastaCol").hide();
                    }
                });
            </script>

        </div>

        <!--
		SMARTPHONE AND DESKTOP MAIN COLUMN
		-->

        <div class="col2" ondragstart="drag(event)">
            <div class="link">
                <br>
                <asp:Button ID="Button1" runat="server" Text="Logout" OnClick="Button1_Click" CssClass="button" />
                <asp:Button ID="Button2" runat="server" Text="Back" OnClick="Button2_Click" CssClass="button" />
            </div>
            <br>
            <br>
            <h1>Relax Area</h1>
            <div class="BevandeCol">
                <h3>Spa</h3>
                <div id="ciabatte-spa" class="item" draggable="true" data-nome="Ciabatte Spa" data-prezzo="0.5">
                    <img class="img-responsive" src="img/ciabatte_spa.jpg" alt="" draggable="false">
                    <p>Ciabatte Spa</p>
                    <p>Price: € 0.5</p>
                </div>
                <div id="asciugamano-spa" class="item" draggable="true" data-nome="Asciugamano Spa" data-prezzo="0.5">
                    <img class="img-responsive" src="img/asciugamano-spa.png" alt="" draggable="false">
                    <p>Asciugamano Spa</p>
                    <p>Price: € 0.5</p>
                </div>
                <div id="accappatoio-spa" class="item" draggable="true" data-nome="Accappatoio Spa" data-prezzo="0.5">
                    <img class="img-responsive" src="img/accappatoio-spa.jpg" alt="" draggable="false">
                    <p>Accappatoio Spa</p>
                    <p>Price: € 0.5</p>
                </div>
            </div>
            <div class="PastaCol">
                <h3>Pool</h3>
                <div id="crema-piscina" class="item" draggable="true" data-nome="Crema Solare" data-prezzo="2">
                    <img class="img-responsive" src="img/crema-piscina.jpg" alt="" draggable="false">
                    <p>Crema Solare</p>
                    <p>Price: € 2</p>
                </div>
                <div id="cuffietta-piscina" class="item" draggable="true" data-nome="Cuffietta" data-prezzo="2">
                    <img class="img-responsive" src="img/cuffietta-piscina.jpg" alt="" draggable="false">
                    <p>Cuffietta</p>
                    <p>Price: € 2</p>
                </div>
                <div id="ciabatte-piscina" class="item" draggable="true" data-nome="Ciabatte da Piscina" data-prezzo="2">
                    <img class="img-responsive" src="img/ciabatte-piscina.jpg" alt="" draggable="false">
                    <p>Ciabatte da Piscina</p>
                    <p>Price: € 2</p>
                </div>
            </div>
        </div>


        <!--
		DESKTOP CART
		-->
        <div class="col3" ondrop="drop(event)" ondragover="allowDrop(event)">
            <h1>Cart</h1>
            <table id="dropzone" fitcolumns="true">
                <tr>
                    <th width="140" align="left"><b>Nome</b></th>
                    <th width="60" align="left"><b>&#35;</b></th>
                    <th width="60" align="left"><b>€</b></th>
                    <th></th>
                </tr>
            </table>
            <p>
                <b>Total:</b> €
                <output id="sommatoria">0.00</output>
            </p>
            <p><i>Drop here article to add it to the cart</i></p>

            <a href="#openModal" onclick="makeID();">
            <asp:Image ID="Image1" src="img/paypal.png" onclick="makeid()" runat="server" height="27px" width="95px" style="background-color: transparent; border-color: transparent; font-size: 30px;" />
            <!--
            TODO: IF BUDGET IS PASSED, STOP BUYING
            -->

            <div id="openModal" class="modalDialog">
                <div>
                    <a href="#close" title="Close" class="close">X</a>
                    <h2>Payment completed!</h2>
                    <p>Thank you for enjoying SUOMI!</p>
                </div>
            </div>
        </div>

    </body>

</asp:Content>
