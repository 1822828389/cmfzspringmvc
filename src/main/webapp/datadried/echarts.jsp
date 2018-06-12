<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta charset="utf-8">
    <!-- 引入 ECharts 文件 -->
    <script src="http://cdn-hangzhou.goeasy.io/goeasy.js"></script>
    <script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

</head>
<body>
<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<div id="main" style="width: 600px;height:400px;"></div>
</body>

<script type="text/javascript">
    var myChart = echarts.init(document.getElementById('main'));

    var goEasy = new GoEasy({
        appkey: "BS-12fb04b37e2444c18ba4e22ce7e5bcea"
    });
    goEasy.subscribe({
        channel: "my_channel",
        onMessage: function (message) {

            var data = JSON.parse(message.content)
            console.log(data);
            var option = {
                title: {
                    text: 'ECharts 入门示例',
                    subtext: '这是副标题',
                },
                /*提示框组件*/
                tooltip: {},
                /*选项卡*/
                legend: {
                    data: ['柱状', "折线"]
                },
                xAxis: {
                    data: ["衬衫1", "羊毛衫", "雪纺衫", "裤子", "高跟鞋", "袜子"]
                },
                yAxis: {},

                series: [{
                    name: '柱状',
                    type: 'bar',
                    data: data.data
                }, {
                    name: '折线',
                    type: 'line',
                    data: data.data
                }]
            };
            myChart.setOption(option);
        }
    })


    // 使用刚指定的配置项和数据显示图表。


    // 指定图表的配置项和数据


</script>
</html>
