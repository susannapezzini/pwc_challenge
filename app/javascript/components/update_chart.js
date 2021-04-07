export default function addData(chart, label, data) {
  chart.data.labels = label;
  console.log(label);
  if (label[0] != 'Banco Ctt') { data[0] = 1.89 }
  if (label[1] != 'Bankinter') { data[1] = 5.56}
  chart.data.datasets.forEach((dataset) => {
      dataset.data = data;
 });
  chart.update();
}