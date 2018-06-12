<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<div id="main1" style="width: 600px;height:400px;"></div>

<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main1'));
    $.ajax({
        url:"${pageContext.request.contextPath}/user/querynumbytime",
        type:"get",
        dataType:"JSON",
        success:function (data) {
            // 指定图表的配置项和数据
            var option = {
                title: {
                    text: '持明法洲App活跃用户',
                    subtext:'全球最大的佛教App',
                },
                tooltip: {},
                legend: {
                    data:['柱形','折线']
                },
                xAxis: {
                    data: ["7天","15天","30天","90天","半年","一年"]
                },
                yAxis: {},
                series:[{
                    name:'柱形',
                    type:'bar',
                    data:data
                },{
                    name:'折线',
                    type:'line',
                    data:data
                }]
            };

            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        }
    })
</script>