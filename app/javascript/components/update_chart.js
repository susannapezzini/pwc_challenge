export default function addData(chart, label, data) {
  chart.data.labels = label;
  // console.log(label);
  chart.data.datasets.forEach((dataset) => {
      dataset.data = data;
 });
  chart.update();
}