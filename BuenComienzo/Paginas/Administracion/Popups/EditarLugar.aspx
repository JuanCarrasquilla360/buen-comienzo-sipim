<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarLugar.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.Popups.EditarLugar" %>

<style type="text/css">
    .row .title {
        background-color: #e0dbdb;
    }

        .row .title span {
            font-size: 14px;
        }

    .boxAcordion {
        display: block;
        z-index: 1999;
        position: relative;
        border: 1px solid #ccc;
        background: transparent;
        margin-bottom: 20px;
    }

    .full-content .boxboxAcordion {
        border: 0;
        margin-bottom: 0;
        -webkit-border-radius: 0;
        -moz-border-radius: 0;
        border-radius: 0;
    }

    .boxAcordion-header {
        color: #505559;
        position: relative;
        overflow: hidden;
        height: 24px;
        border-bottom: 1px solid #ccc;
        background-color: #eaeaea;
        background-image: -webkit-linear-gradient(top, #eaeaea, #e0e0e0);
        background-image: -moz-linear-gradient(top, #eaeaea, #e0e0e0);
        background-image: -ms-linear-gradient(top, #eaeaea, #e0e0e0);
        background-image: -o-linear-gradient(top, #eaeaea, #e0e0e0);
        background-image: linear-gradient(to bottom, #eaeaea, #e0e0e0);
    }

    .boxAcordion-name, .modal-header-name {
        padding-left: 15px;
        line-height: 24px;
    }

        .boxAcordion-name > i {
            margin-right: 5px;
        }

    .boxAcordion-icons {
        position: absolute;
        top: 0;
        right: 0;
        z-index: 9;
    }

    .no-move {
        display: none;
    }

    .expanded .no-move {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 1;
        display: block;
    }

    .boxboxAcordion-content {
        position: relative;
        padding: 15px;
        background: #FFFFFF;
    }

    .boxAcordion-content.dropbox, .box-content.sortablebox {
        overflow: hidden;
    }

    .full-content .boxAcordion-content {
        height: 100%;
        position: absolute;
        width: 100%;
        left: 0;
        top: 0;
    }

    boxAcordion-icons a {
        cursor: pointer;
        text-decoration: none !important;
        border-left: 1px solid #FFFFFF;
        height: 24px;
        line-height: 24px;
        font-size: 12px;
        width: 28px;
        display: block;
        float: left;
        text-align: center;
        color: #505559;
        -webkit-transition: 0.2s;
        -moz-transition: 0.2s;
        -o-transition: 0.2s;
        transition: 0.2s;
    }

    .boxAcordion-icons a:hover {
        background: #FFFFFF;
        color: #505559;
    }

    .boxAcordion-icons a.beauty-table-to-json {
        width: auto;
        padding: 0 10px;
        font-size: 14px;
    }

    .expanded a.close-link {
        display: none;
    }

    .ring-1 {
        width: 10px;
        height: 10px;
        margin: 0 auto;
        padding: 10px;
        border: 7px dashed #4b9cdb;
        border-radius: 100%;
    }

    .load-4 .ring-1 {
        animation: loadingD 1.5s .3s cubic-bezier(.17,.37,.43,.67) infinite;
    }

    .l-4 {
        animation-delay: .84s;
    }

    @keyframes loadingD {
        0 {
            transform: rotate(0deg);
        }

        50% {
            transform: rotate(180deg);
        }

        100% {
            transform: rotate(360deg);
        }
    }

    .VariableTitle h5 {
        font-weight: bold;
    }

    .lineBottom {
        border-bottom: 1px solid #808080;
    }
</style>

<form id="EditarLugar">

    <div class="panelInformativo" id="pnlGeneral">
        <div class="boxAcordion" style="margin-top: 10px; margin-bottom: 5px">
            <div class="boxAcordion-header">
                <div class="boxAcordion-name">
                    <i class="fa fa-user"></i>
                    <span>Lugar</span>
                </div>
                <div class="boxAcordion-icons">
                    <a class="collapse-link">
                        <i class="fa fa-chevron-up"></i>
                    </a>
                </div>
                <div class="no-move"></div>
            </div>
            <div class='boxAcordion-content' style='padding: 0px'>

                <div class="row" style="padding: 4px 4px 4px 4px;">
                    <div class="col-sm-12">
                        <div class="col-sm-2">
                            <label class="control-label">Código DANE</label>
                        </div>
                        <div class="col-sm-4">
                            <input type="text" id="txtDane" maxlength="15" runat="server" class="form-control onlyNumbers" >
                        </div>
                        <div class="col-sm-2">
                            <label class="control-label">Nit</label>
                        </div>
                        <div class="col-sm-4">
                            <input type="text" id="txtNit" maxlength="15" runat="server" class="form-control onlyNumbers">
                        </div>
                    </div>
                </div>

                <div class="row" style="padding: 4px 4px 4px 4px;">
                    <div class="col-sm-12">
                        <div class="col-sm-2">
                            <label class="control-label">Tipo de Lugar</label>
                        </div>
                        <div class="col-sm-4">
                            <select id="ddlTipoLugar" runat="server" class="form-control" data-validation="required">
                                <option value="">Seleccione</option>
                                <option value="BUEN COMIENZO">BUEN COMIENZO</option>
                                <option value="COMUNITARIO">COMUNITARIO</option>
                                <option value="ICBF">ICBF</option>
                                <option value="INSTITUCIÓN EDUCATIVA">INSTITUCIÓN EDUCATIVA</option>
                                <option value="UNIVERSIDAD">UNIVERSIDAD</option>
                            </select>
                        </div>
                        <div class="col-sm-2">
                            <label class="control-label">Tipo de Modalidad</label>
                        </div>
                        <div class="col-sm-4">
                            <select id="ddlTipoModalidad" runat="server" class="form-control" data-validation="required">
                                <option value="">Seleccione</option>
                                <option value="COMUNITARIO">COMUNITARIO</option>
                                <option value="INSTITUCIÓN EDUCATIVA">INSTITUCIÓN EDUCATIVA</option>
                                <option value="INSTITUCIONAL 8 HORAS">INSTITUCIONAL 8 HORAS</option>
                                <option value="JARDINES INFANTILES">JARDINES INFANTILES</option>
                                <option value="LUDOTEKAS">LUDOTEKAS</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row" style="padding: 4px 4px 4px 4px;">
                    <div class="col-sm-12">
                        <div class="col-sm-2">
                            <label class="control-label">Nombre del Lugar</label>
                        </div>
                        <div class="col-sm-4">
                            <input type="text" id="txtNombreLugar" runat="server" data-validation="required" class="form-control" onkeyup="this.value = this.value.toUpperCase();" >
                        </div>
                        <div class="col-sm-2">
                            <label class="control-label">Entorno</label>
                        </div>
                        <div class="col-sm-4">
                            <select id="ddlEntorno" runat="server" class="form-control" data-validation="required"></select>
                        </div>
                    </div>
                </div>

                <div class="row" style="padding: 4px 4px 4px 4px;">
                    <div class="col-sm-12">
                        <div class="col-sm-2">
                            <label class="control-label">Comuna</label>
                        </div>
                        <div class="col-sm-4">
                            <select id="ddlComuna" runat="server" class="form-control" data-validation="required"></select>
                        </div>
                        <div class="col-sm-2">
                            <label class="control-label">Barrio</label>
                        </div>
                        <div class="col-sm-4">
                            <select id="ddlBarrio" runat="server" class="form-control" data-validation="required" disabled></select>
                        </div>
                    </div>
                </div>                

                <div class="row form-group" style="padding: 4px 4px 4px 4px;">
                    <div class="col-sm-12">
                        <div class="col-sm-2">
                            <label class="control-label">Dirección</label>
                        </div>
                        <div class="col-sm-7 group">
                            <table>
                                <tr>
                                    <td style="padding: 0px 7px 3px 0px">
                                        <select id="ddlTipoVia" runat="server" class="form-control" data-validation="required" onchange="editarDireccion()">
                                            <option value=""></option>
                                            <option value="AV">Avenida</option>
                                            <option value="BLV">Bulevar</option>
                                            <option value="CL">Calle</option>
                                            <option value="CR">Carrera</option>
                                            <option value="CRT">Carretera</option>
                                            <option value="CIR">Circular</option>
                                            <option value="CRV">Circunvalar</option>
                                            <option value="DG">Diagonal</option>
                                            <option value="TV">Transversal</option>
                                            <option value="TC">Troncal</option>
                                            <option value="VT">Variante</option>
                                            <option value="VI">Vía</option>
                                            <option value="CRG">Corregimiento</option>
                                            <option value="KM">Kilómetro</option>
                                            <option value="VRD">Vereda</option>
                                            <option value="AUT">Autopista </option>
                                        </select>
                                    </td>
                                    <td style="padding: 0px 7px 0px 0px">
                                        <input type="text" id="txtVia1" runat="server" class="form-control" maxlength="20" data-validation="required" style="width: 150px;" onblur="editarDireccion()" onchange="editarDireccion()">
                                    </td>
                                    <td style="padding: 0px 7px 0px 0px">
                                        <select id="ddlApendice1" runat="server" class="form-control" onchange="editarDireccion()">
                                            <option value=""></option>
                                            <option value="A">A </option>
                                            <option value="AA">AA </option>
                                            <option value="AB">AB </option>
                                            <option value="AC">AC </option>
                                            <option value="AD">AD </option>
                                            <option value="AE">AE </option>
                                            <option value="AF">AF </option>
                                            <option value="AG">AG </option>
                                            <option value="AH">AH </option>
                                            <option value="B">B </option>
                                            <option value="BB">BB </option>
                                            <option value="BA">BA </option>
                                            <option value="BC">BC </option>
                                            <option value="BD">BD </option>
                                            <option value="BE">BE </option>
                                            <option value="BF">BF </option>
                                            <option value="BG">BG </option>
                                            <option value="BH">BH </option>
                                            <option value="C">C </option>
                                            <option value="CC">CC </option>
                                            <option value="CA">CA </option>
                                            <option value="CB">CB </option>
                                            <option value="CD">CD </option>
                                            <option value="CE">CE </option>
                                            <option value="CF">CF </option>
                                            <option value="CG">CG </option>
                                            <option value="CH">CH </option>
                                            <option value="D">D </option>
                                            <option value="DD">DD </option>
                                            <option value="DA">DA </option>
                                            <option value="DB">DB </option>
                                            <option value="DC">DC </option>
                                            <option value="DE">DE </option>
                                            <option value="DF">DF </option>
                                            <option value="DG">DG </option>
                                            <option value="DH">DH </option>
                                            <option value="E">E </option>
                                            <option value="EE">EE </option>
                                            <option value="EA">EA </option>
                                            <option value="EB">EB </option>
                                            <option value="EC">EC </option>
                                            <option value="ED">ED </option>
                                            <option value="EF">EF </option>
                                            <option value="EG">EG </option>
                                            <option value="EH">EH </option>
                                            <option value="F">F </option>
                                            <option value="FF">FF </option>
                                            <option value="FA">FA </option>
                                            <option value="FB">FB </option>
                                            <option value="FC">FC </option>
                                            <option value="FD">FD </option>
                                            <option value="FE">FE </option>
                                            <option value="FG">FG </option>
                                            <option value="FH">FH </option>
                                            <option value="G">G </option>
                                            <option value="GG">GG </option>
                                            <option value="GA">GA </option>
                                            <option value="GB">GB </option>
                                            <option value="GC">GC </option>
                                            <option value="GD">GD </option>
                                            <option value="GE">GE </option>
                                            <option value="GF">GF </option>
                                            <option value="GH">GH </option>
                                            <option value="H">H </option>
                                            <option value="HH">HH </option>
                                            <option value="HA">HA </option>
                                            <option value="HB">HB </option>
                                            <option value="HC">HC </option>
                                            <option value="HD">HD </option>
                                            <option value="HE">HE </option>
                                            <option value="HF">HF </option>
                                            <option value="HG">HG </option>
                                        </select>
                                    </td>
                                    <td style="padding: 0px 7px 0px 0px">
                                        <select id="ddlCardinalidad" runat="server" class="form-control" onchange="editarDireccion()">
                                            <option value=""></option>
                                            <option value="ESTE ">Este </option>
                                            <option value="NORTE ">Norte </option>
                                            <option value="OESTE ">Oeste </option>
                                            <option value="SUR ">Sur </option>

                                        </select>
                                    </td>
                                    <td>
                                        <label class="control-label">#&nbsp;</label>
                                    </td>
                                    <td style="padding: 0px 7px 0px 0px">
                                        <input type="text" id="txtVia2" runat="server" class="form-control" maxlength="3" data-validation="required" style="width: 49px;" onblur="editarDireccion()" onchange="editarDireccion()">
                                    </td>
                                    <td style="padding: 0px 7px 0px 0px">
                                        <select id="ddlApendice2" runat="server" class="form-control" onchange="editarDireccion()">
                                            <option value=""></option>
                                            <option value="A">A </option>
                                            <option value="AA">AA </option>
                                            <option value="AB">AB </option>
                                            <option value="AC">AC </option>
                                            <option value="AD">AD </option>
                                            <option value="AE">AE </option>
                                            <option value="AF">AF </option>
                                            <option value="AG">AG </option>
                                            <option value="AH">AH </option>
                                            <option value="B">B </option>
                                            <option value="BB">BB </option>
                                            <option value="BA">BA </option>
                                            <option value="BC">BC </option>
                                            <option value="BD">BD </option>
                                            <option value="BE">BE </option>
                                            <option value="BF">BF </option>
                                            <option value="BG">BG </option>
                                            <option value="BH">BH </option>
                                            <option value="C">C </option>
                                            <option value="CC">CC </option>
                                            <option value="CA">CA </option>
                                            <option value="CB">CB </option>
                                            <option value="CD">CD </option>
                                            <option value="CE">CE </option>
                                            <option value="CF">CF </option>
                                            <option value="CG">CG </option>
                                            <option value="CH">CH </option>
                                            <option value="D">D </option>
                                            <option value="DD">DD </option>
                                            <option value="DA">DA </option>
                                            <option value="DB">DB </option>
                                            <option value="DC">DC </option>
                                            <option value="DE">DE </option>
                                            <option value="DF">DF </option>
                                            <option value="DG">DG </option>
                                            <option value="DH">DH </option>
                                            <option value="E">E </option>
                                            <option value="EE">EE </option>
                                            <option value="EA">EA </option>
                                            <option value="EB">EB </option>
                                            <option value="EC">EC </option>
                                            <option value="ED">ED </option>
                                            <option value="EF">EF </option>
                                            <option value="EG">EG </option>
                                            <option value="EH">EH </option>
                                            <option value="F">F </option>
                                            <option value="FF">FF </option>
                                            <option value="FA">FA </option>
                                            <option value="FB">FB </option>
                                            <option value="FC">FC </option>
                                            <option value="FD">FD </option>
                                            <option value="FE">FE </option>
                                            <option value="FG">FG </option>
                                            <option value="FH">FH </option>
                                            <option value="G">G </option>
                                            <option value="GG">GG </option>
                                            <option value="GA">GA </option>
                                            <option value="GB">GB </option>
                                            <option value="GC">GC </option>
                                            <option value="GD">GD </option>
                                            <option value="GE">GE </option>
                                            <option value="GF">GF </option>
                                            <option value="GH">GH </option>
                                            <option value="H">H </option>
                                            <option value="HH">HH </option>
                                            <option value="HA">HA </option>
                                            <option value="HB">HB </option>
                                            <option value="HC">HC </option>
                                            <option value="HD">HD </option>
                                            <option value="HE">HE </option>
                                            <option value="HF">HF </option>
                                            <option value="HG">HG </option>
                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" id="txtPlaca" runat="server" class="form-control" maxlength="3" data-validation="required" style="width: 49px;" onblur="editarDireccion()" onchange="editarDireccion()">
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-sm-3">
                            <label id="lblDireccion" runat="server" class="control-label" style="font-size: 16px; margin-top: 6px"></label>
                        </div>
                    </div>
                </div>

                    
                <div class="row" style="padding: 4px 4px 4px 4px;">
                    <div class="col-sm-12">
                        <div class="col-sm-2">
                            <label class="control-label">Teléfono 1</label>
                        </div>
                        <div class="col-sm-4">
                            <input type="tel" id="txtTelefono1" runat="server" class="form-control" maxlength="10" data-validation="number required">
                        </div>
                        <div class="col-sm-2">
                            <label class="control-label">Teléfono 2</label>
                        </div>
                        <div class="col-sm-4">
                            <input type="text" id="txtTelefono2" runat="server" class="form-control" maxlength="10" >
                        </div>
                    </div>
                </div>

                <div class="row" style="padding: 4px 4px 4px 4px;">
                    <div class="col-sm-12">
                        <div class="col-sm-2">
                            <label class="control-label">Responsable del Lugar</label>
                        </div>
                        <div class="col-sm-4">
                            <input type="text" id="txtNombreResponsable" runat="server" class="form-control" data-validation="required">
                        </div>
                    </div>
                </div>
               
            </div>
        </div>
    </div>

</form>