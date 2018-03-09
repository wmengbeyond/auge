<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- iCheck for checkboxes and radio inputs -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/adminlte/plugins/iCheck/all.css">

<!-- iCheck 1.0.1 -->
<script src="${pageContext.request.contextPath}/adminlte/plugins/iCheck/icheck.min.js"></script>

<script>
    // 查询参数
    search_type = 0
    search_keyWord = null

    $(function(){
        datePickerInit();
        baseTableInit();
        searchActionInit();
        checkInit();

/*        addWarehouseAction();
        editWarehouseAction();
        deleteWarehouseAction();*/
    })

    function checkInit() {
        //iCheck for checkbox and radio inputs
        $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass: 'iradio_minimal-blue'
        });
        //Red color scheme for iCheck
        $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
            checkboxClass: 'icheckbox_minimal-red',
            radioClass: 'iradio_minimal-red'
        });
        //Flat red color scheme for iCheck
        $('input[type="checkbox"].square-green, input[type="radio"].square-green').iCheck({
            checkboxClass: 'icheckbox_flat-green',
            radioClass: 'iradio_flat-green'
        });

    }

    // 日期选择器初始化
	function datePickerInit(){
		$('.form_date').datetimepicker({
			format:'yyyy-mm-dd',
			language : 'zh-CN',
			endDate : new Date(),
			weekStart : 1,
			todayBtn : 1,
			autoClose : 1,
			todayHighlight : 1,
			startView : 2,
			forceParse : 0,
			minView:2
		});
	}

	// 表格初始化
	function baseTableInit(){
	    $('#baseRecordDOS').bootstrapTable({
	        columns:[{
	            field : 'id',
	            title : '记录ID'
	        },{
	            field : 'code',
	            title : '编号'
	        },{
	            field : 'name',
	            title : '名称'
	        },{
	            field : 'addr',
	            title : '地址'
	        },{
	            field : 'tel',
	            title : '座机'
	        },{
	            field : 'contact',
	            title : '负责人'
            },{
                field : 'phone',
                title : '负责人手机'
            },{
                field : 'operation',
                title : '操作',
                formatter : function(value, row, index) {
                    var s = '<button class="btn btn-info btn-sm edit"><span>编辑</span></button>';
                    var d = '<button class="btn btn-danger btn-sm delete"><span>删除</span></button>';
                    var fun = '';
                    return s + ' ' + d;
                },
                events : {
                    // 操作列中编辑按钮的动作
                    'click .edit' : function(e, value,
                                             row, index) {
                        selectID = row.id;
                        rowEditOperation(row);
                    },
                    'click .delete' : function(e,
                                               value, row, index) {
                        selectID = row.id;
                        $('#deleteWarning_modal').modal(
                            'show');
                    }
                }
	        }],
	        url : 'baseManage/getWarehouseRecords',
            onLoadError:function(status){
                handleAjaxError(status);
            },
	        method : 'GET',
	        queryParams : queryParams,
            sidePagination : "server",
            dataType : 'json',
            pagination : true,
            pageNumber : 1,
            pageSize : 5,
            pageList : [ 5, 10, 25, 50, 100 ],
            clickToSelect : true
	    });
	}

	// 表格刷新
	function tableRefresh() {
		$('#baseRecordDOS').bootstrapTable('refresh', {
			query : {}
		});
	}

	// 分页查询参数
	function queryParams(params) {
		var temp = {
			limit : params.limit,
			offset : params.offset,
            keyWord : search_keyWord,
            searchType : search_type
		}
		return temp;
	}

    // 行编辑操作
    function rowEditOperation(row) {
        $('#edit_modal').modal("show");

        // load info
        $('#warehouse_form_edit').bootstrapValidator("resetForm", true);
        $('#warehouse_code_edit').val(row.name);
        $('#warehouse_name_edit').val(row.name);
        $('#warehouse_addr_edit').val(row.addr);
        $('#warehouse_tel_edit').val(row.tel);
        $('#warehouse_contact_edit').val(row.contact);
        $('#warehouse_phone_edit').val(row.phone);
    }

    // 查询操作
    function searchActionInit(){
        $('#search_button').click(function(){
            keyWord = $('#keyWord').val();
            search_type = $('#search_type').val();
            tableRefresh();
        })
    }
</script>

<div class="panel panel-default">
    <ol class="breadcrumb">
        <li>中心仓数据</li>
    </ol>
    <div class="panel-body">
        <div class="row">
            <div class="col-md-4">
                <form action="" class="form-inline">
                    <div class="form-group">
                        <label class="form-label">搜索：</label>
                        <label>
                            <input type="radio" name="r3" class="square-green" checked>
                            名称
                        </label>
                        <label>
                            <input type="radio" name="r3" class="square-green">
                            负责人
                        </label>
                        <label>
                            <input type="radio" name="r3" class="square-green">
                            编号
                        </label>
                    </div>
                </form>
            </div>
            <div class="col-md-2">
                <input type="text" id="key_word" class="form-control" placeholder="指定关键字">
            </div>
            <div class="col-md-2">
                <button class="btn btn-success" id="search_button">
                    <span class="glyphicon glyphicon-search"></span> <span>查询</span>
                </button>
            </div>
        </div>
        <div class="row" style="margin-top:25px">
            <div class="col-md-12">
                <table class="table table-striped" id="baseRecordDOS"></table>
            </div>
        </div>
    </div>
</div>

<!-- 添加货物信息模态框 -->
<div id="add_modal" class="modal fade" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加货物信息</h4>
            </div>
            <div class="modal-body">
                <!-- 模态框的内容 -->
                <div class="row">
                    <div class="col-md-1 col-sm-1"></div>
                    <div class="col-md-8 col-sm-8">
                        <form class="form-horizontal" role="form" id="goods_form"
                              style="margin-top: 25px">
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>货物名称：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control" id="goods_name"
                                           name="goods_name" placeholder="货物名称">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>货物类型：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control" id="goods_type"
                                           name="goods_type" placeholder="货物类型">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>货物尺寸：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control" id="goods_size"
                                           name="goods_size" placeholder="货物尺寸">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>货物价值：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control" id="goods_value"
                                           name="goods_value" placeholder="货物价值">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-1 col-sm-1"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span>取消</span>
                </button>
                <button class="btn btn-success" type="button" id="add_modal_submit">
                    <span>提交</span>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 导入货物信息模态框 -->
<div class="modal fade" id="import_modal" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">导入货物信息</h4>
            </div>
            <div class="modal-body">
                <div id="step1">
                    <div class="row" style="margin-top: 15px">
                        <div class="col-md-1 col-sm-1"></div>
                        <div class="col-md-10 col-sm-10">
                            <div>
                                <h4>点击下面的下载按钮，下载货物信息电子表格</h4>
                            </div>
                            <div style="margin-top: 30px; margin-buttom: 15px">
                                <a class="btn btn-info"
                                   href="commons/fileSource/download/goodsInfo.xlsx"
                                   target="_blank"> <span class="glyphicon glyphicon-download"></span>
                                    <span>下载</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="step2" class="hide">
                    <div class="row" style="margin-top: 15px">
                        <div class="col-md-1 col-sm-1"></div>
                        <div class="col-md-10 col-sm-10">
                            <div>
                                <h4>请按照货物信息电子表格中指定的格式填写需要添加的一个或多个货物信息</h4>
                            </div>
                            <div class="alert alert-info"
                                 style="margin-top: 10px; margin-buttom: 30px">
                                <p>注意：表格中各个列均不能为空，若存在未填写的项，则该条信息将不能成功导入</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="step3" class="hide">
                    <div class="row" style="margin-top: 15px">
                        <div class="col-md-1 col-sm-1"></div>
                        <div class="col-md-8 col-sm-10">
                            <div>
                                <div>
                                    <h4>请点击下面上传文件按钮，上传填写好的货物信息电子表格</h4>
                                </div>
                                <div style="margin-top: 30px; margin-buttom: 15px">
									<span class="btn btn-info btn-file"> <span> <span
                                            class="glyphicon glyphicon-upload"></span> <span>上传文件</span>
									</span>
									<form id="import_file_upload"><input type="file" id="file" name="file"></form>
									</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="hide" id="uploading">
                    <div class="row" style="margin-top: 15px" id="import_progress_bar">
                        <div class="col-md-1 col-sm-1"></div>
                        <div class="col-md-10 col-sm-10"
                             style="margin-top: 30px; margin-bottom: 30px">
                            <div class="progress progress-striped active">
                                <div class="progress-bar progress-bar-success"
                                     role="progreessbar" aria-valuenow="60" aria-valuemin="0"
                                     aria-valuemax="100" style="width: 100%;">
                                    <span class="sr-only">请稍后...</span>
                                </div>
                            </div>
                            <!--
                            <div style="text-align: center">
                                <h4 id="import_info"></h4>
                            </div>
                             -->
                        </div>
                        <div class="col-md-1 col-sm-1"></div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 col-sm-4"></div>
                        <div class="col-md-4 col-sm-4">
                            <div id="import_result" class="hide">
                                <div id="import_success" class="hide" style="text-align: center;">
                                    <img src="media/icons/success-icon.png" alt=""
                                         style="width: 100px; height: 100px;">
                                </div>
                                <div id="import_error" class="hide" style="text-align: center;">
                                    <img src="media/icons/error-icon.png" alt=""
                                         style="width: 100px; height: 100px;">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-4"></div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-3 col-sm-3"></div>
                        <div class="col-md-6 col-sm-6" style="text-align: center;">
                            <h4 id="import_info"></h4>
                        </div>
                        <div class="col-md-3 col-sm-3"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn ben-default" type="button" id="previous">
                    <span>上一步</span>
                </button>
                <button class="btn btn-success" type="button" id="next">
                    <span>下一步</span>
                </button>
                <button class="btn btn-success hide" type="button" id="submit">
                    <span>&nbsp;&nbsp;&nbsp;提交&nbsp;&nbsp;&nbsp;</span>
                </button>
                <button class="btn btn-success hide disabled" type="button"
                        id="confirm" data-dismiss="modal">
                    <span>&nbsp;&nbsp;&nbsp;确认&nbsp;&nbsp;&nbsp;</span>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 导出货物信息模态框 -->
<div class="modal fade" id="export_modal" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">导出货物信息</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-3 col-sm-3" style="text-align: center;">
                        <img src="media/icons/warning-icon.png" alt=""
                             style="width: 70px; height: 70px; margin-top: 20px;">
                    </div>
                    <div class="col-md-8 col-sm-8">
                        <h3>是否确认导出货物信息</h3>
                        <p>(注意：请确定要导出的货物信息，导出的内容为当前列表的搜索结果)</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span>取消</span>
                </button>
                <button class="btn btn-success" type="button" id="export_goods_download">
                    <span>确认下载</span>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 删除提示模态框 -->
<div class="modal fade" id="deleteWarning_modal" table-index="-1"
     role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">警告</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-3 col-sm-3" style="text-align: center;">
                        <img src="media/icons/warning-icon.png" alt=""
                             style="width: 70px; height: 70px; margin-top: 20px;">
                    </div>
                    <div class="col-md-8 col-sm-8">
                        <h3>是否确认删除该条货物信息</h3>
                        <p>(注意：若该货物已经有仓库进出库记录或有仓存记录，则该货物信息将不能删除成功。如需删除该货物的信息，请先确保该货物没有关联的仓库进出库记录或有仓存记录)</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span>取消</span>
                </button>
                <button class="btn btn-danger" type="button" id="delete_confirm">
                    <span>确认删除</span>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 编辑货物信息模态框 -->
<div id="edit_modal" class="modal fade" table-index="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">仓库基本信息</h4>
            </div>
            <div class="modal-body">
                <!-- 模态框的内容 -->
                <div class="row">
                    <div class="col-md-1 col-sm-1"></div>
                    <div class="col-md-8 col-sm-8">
                        <form class="form-horizontal" role="form" id="warehouse_form_edit"
                              style="margin-top: 25px">
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>编码：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control" id="warehouse_code_edit"
                                           name="warehouse_code" placeholder="编码">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>名称：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control"
                                           id="warehouse_name_edit" name="warehouse_name"
                                           placeholder="名称">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>地址：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control" id="warehouse_addr_edit"
                                           name="warehouse_addr" placeholder="地址">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>座机：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control"
                                           id="warehouse_tel_edit" name="warehouse_tel"
                                           placeholder="座机">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>负责人：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control"
                                           id="warehouse_contact_edit" name="warehouse_contact"
                                           placeholder="负责人">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>手机：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
                                    <input type="text" class="form-control"
                                           id="warehouse_phone_edit" name="warehouse_phone"
                                           placeholder="手机">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-1 col-sm-1"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">
                    <span>取消</span>
                </button>
                <button class="btn btn-success" type="button" id="edit_modal_submit">
                    <span>确认更改</span>
                </button>
            </div>
        </div>
    </div>
</div>