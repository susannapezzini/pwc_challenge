const createDataset = (labels, values) => {
  const colors = ['rgba(116,25,16,0.7)', 'rgba(170,36,23,0.7)', 'rgba(224,48,30,0.7)', 'rgba(232,97,83,0.7)', 'rgba(247,200,196,0.7)', 'rgba(110, 42, 53, 0.7)', 'rgba(164,62,80,0.7)','rgba(219,83,106,0.7)', 'rgba(226,117,136,0.7)', 'rgba(241,186,195,0.7)', 'rgba(255,220,169,0.7)', 'rgba(255,169,41,0.7)', 'rgba(235,140,0,0.7)']
  const borderColors = ['rgb(116,25,16)', 'rgb(170,36,23)', 'rgb(224,48,30)', 'rgb(232,97,83)', 'rgb(247,200,196)','rgba(110, 42, 53)', 'rgba(164,62,80)','rgba(219,83,106)', 'rgba(226,117,136)', 'rgba(241,186,195)','rgba(255,220,169)', 'rgba(255,169,41)', 'rgba(235,140,0)']


  let chartValues = {};
  console.log(labels, values);
  let banks = labels.map(b => {
    return b.split('-')[0];
  })
  
  
  chartValues.datasets = labels.map((l, i) => {
    
    return  ({label: l, 
      data: [values[i]],
      backgroundColor: colors[i],
      borderColor: borderColors[i],
      borderWidth: 1,
      borderWidth: 1
    });
  });
  console.log({chartValues});
  chartValues.labels = banks;
  return chartValues;

}

export default createDataset;