import createChart from './create_chart.js'
import updateChart from './update_chart.js'

const compareChart = () => {
  const elements = [...document.getElementsByClassName("select-group")];
	const subs = [...document.getElementsByClassName("sub-count")];
	const sums = [...document.getElementsByClassName("subproduct-price-sum-dd")];
	const compareBtn = document.getElementById("compare-btn");
  const userGroup = document.getElementById('update_other_bank_groups');
  const userGroupValue = document.getElementById('update_other_bank_groups').value;
  const ctx = document.getElementById("one-subproduct-all-bank-chart");
	const ctx2 = document.getElementById("pie-chart-subproduct");
	const ctx3 = document.getElementById("demand-deposit-sum-chart");
	const ctx4 = document.getElementById("subproduct-chart");

  
  
  const pairingColors = () => {
    // const colors = ['rgba(116,25,16,0.7)', 'rgba(170,36,23,0.7)', 'rgba(224,48,30,0.7)', 'rgba(232,97,83,0.7)', 'rgba(247,200,196,0.7)', 'rgba(110, 42, 53, 0.7)', 'rgba(164,62,80,0.7)','rgba(219,83,106,0.7)', 'rgba(226,117,136,0.7)', 'rgba(241,186,195,0.7)', 'rgba(255,220,169,0.7)', 'rgba(255,169,41,0.7)', 'rgba(235,140,0,0.7)']
    const colors = ['rgb(116,25,16)', 'rgb(170,36,23)', 'rgb(224,48,30)', 'rgb(232,97,83)', 'rgb(247,200,196)','rgba(110, 42, 53)', 'rgba(164,62,80)','rgba(219,83,106)', 'rgba(226,117,136)', 'rgba(241,186,195)','rgba(255,220,169)', 'rgba(255,169,41)', 'rgba(235,140,0)']
    console.log('colors', colors.length)
    return [colors[1], colors[1], colors[12],colors[12], colors[2], colors[2], colors[10], colors[10], colors[3], colors[3]];
  }
    
  const randomColor = () => {
    // const colors = ['rgba(116,25,16,0.7)', 'rgba(170,36,23,0.7)', 'rgba(224,48,30,0.7)', 'rgba(232,97,83,0.7)', 'rgba(255,220,169,0.7)', 'rgba(255,169,41,0.7)', 'rgba(235,140,0,0.7)', 'rgba(247,200,196,0.7)', 'rgba(110, 42, 53, 0.7)', 'rgba(164,62,80,0.7)','rgba(219,83,106,0.7)', 'rgba(226,117,136,0.7)', 'rgba(241,186,195,0.7)']
    const colors = ['rgb(116,25,16)','rgba(255,169,41)', 'rgb(170,36,23)','rgba(255,220,169)', 'rgb(232,97,83)','rgba(219,83,106)', 'rgba(235,140,0)','rgb(224,48,30)', 'rgba(110, 42, 53)','rgb(247,200,196)', 'rgba(164,62,80)', 'rgba(226,117,136)', 'rgba(241,186,195)']
    return colors;
  }

  const getLabels = (array) => {
    const labels = array.map((e) => {
      const option = e.options.selectedIndex;
      // console.log({option});
      // console.log({e})
      if (e.attributes.id.ownerElement[option].dataset.bank) {
        return e.attributes.id.ownerElement[option].dataset.bank;
      };
    });
    return labels;
	};

	const getCount = (array) => {
		const data = array.map((e) => {
			const option = e.options.selectedIndex;
			
      return e.attributes.id.ownerElement[option].dataset.tot;

    });
    return data;
	};

  const getPricePieChart = (element) => {
		const option = element.options.selectedIndex;
    return element.attributes.id.ownerElement[option].dataset.price;
  }
  const getFeePieChart = (element) => {
    const option = element.options.selectedIndex;
    return element.attributes.id.ownerElement[option].dataset.fee;
  }
  // const getCountPieChart = (element) => {
	// 	const option = element.options.selectedIndex;
  //   return element.attributes.id.ownerElement[option].dataset.subproductsCount;
  // }

  const setValue = (array, value) => {
    array.map(e => {
      e.value = value;
    })
    return array;
  }

  // Avg costs
  if (!subs) {
    return;
  } else {
    // console.log(subs);
  let labels = getLabels(subs);
  // console.log({labels})
  let data = getCount(subs);
  let type = 'bar';
  let position = 'bottom';
  let chartTitle = `Average Cost - Your Subproducts vs Market`;
  const avgChart = createChart(ctx4, labels, data, type, pairingColors, position, chartTitle);
  }

  // one-subproduct-all-bank-chart
  if (!elements) {
    return;
  } else {
    // console.log(userGroupValue);
    let newEl = setValue(elements, userGroupValue);
    // discard null 
    let availabeData = newEl.filter(e => {
      if (e.value) {
        // console.log(e.value);
        return e;
      }
    });
    let data = getCount(availabeData);
    let labels = getLabels(availabeData);
    let type = 'bar'; 
    let position = 'bottom';
    let chartTitle = 'Average Cost - Selected Subproduct vs Competitors';
    let chart = createChart(ctx, labels, data, type, randomColor, position, chartTitle);
    
    // pie chart 
    let pieFees = getFeePieChart(userGroup).replace('[', '').replace(']', "").replace(/"/g,"").split(',');
    let piePrices = getPricePieChart(userGroup).replace('[', "").replace(']', "").split(',').slice(0, pieFees.length).map(p => {
      return parseFloat(p) || 0;
    });
    console.log({pieFees}, {piePrices});
    

    let pie = 'pie';
    let positionRight = 'right';
    let pieTitle = 'Selected Subproduct Fee Structure';
    let pieChart = createChart(ctx2, pieFees, piePrices, pie, randomColor, positionRight, pieTitle);
    
    
    userGroup.addEventListener('change', (event) => {
      let pieFees = getFeePieChart(userGroup).replace('[', "").replace(']', "").replace('"', '').replace(/"/g,"").split(',');
      let piePrices = getPricePieChart(userGroup).replace('[', "").replace(']', "").split(',').slice(0, pieFees.length).map(p => {
        return parseFloat(p) || 0;
      });
      console.log({pieFees}, {piePrices});
      updateChart(pieChart, pieFees, piePrices);
      
      




      let userGroupValue = document.getElementById('update_other_bank_groups').value;
      let hello = setValue(elements, userGroupValue);
      let shit = hello.filter(e => {
        if (e.value) {
          // console.log(e.value);
          return e;
        }
      });
      // console.log({shit});
      let data = getCount(shit);
      let labels = getLabels(shit);
      updateChart(chart, labels, data);

      
    })
    
    // let availableData = userGroup.addEventListener('change', (event) =>{
    //   elements.map(e => {
    //     e.value = userGroupValue;
    //   })
    //   elements.map(e => {
    //     if (e.value){
    //       return e;
    //     }
    //   })
    //   return availableData;
    // })
    // console.log({availableData});
    // // let labels = getLabels(availableData);
    // // let data = getCount(availableData);
    // // let chart = createChart(ctx, labels, data);
    // compareBtn.addEventListener('click', () => {
    //   let labels = getLabels(availableData);
    //   let data = getCount(availableData);
    //   updateChart(chart, labels, data)
    // });
  }
};
export { compareChart };

// import createChart from './create_chart.js'
// import updateChart from './update_chart.js'

// const compareChart = () => {
//   const elements = [...document.getElementsByClassName("select-subproduct")];
//   const compareBtn = document.getElementById("compare-btn")
//   // const myProduct = elements[0];
//   // const product1 = elements[1];
//   // const product2 = elements[2];
//   // console.log({product1})
//   // console.log({myProduct})

//   let data = []
//   let labels = []

//   const getLabels = (array) => {
//     labels = []
//     array.forEach(e => {
//       const option = e.options.selectedIndex;
//       e = e.attributes.id.ownerElement[option].dataset.bank;
//       labels.push(e);
//       return labels;
//     })
//   }
  
//   const getData = (array) => {
//     data = []
//     array.forEach(e => {
//       const option = e.options.selectedIndex;
//       e = e.attributes.id.ownerElement[option].dataset.subPrice;
//       data.push(e);
//       return data;
//     })

//   }

  
//   const ctx = document.getElementById('product-chart');
//   if (elements) {
//     getLabels(elements);
//     getData(elements);
//     const compareChart = createChart(ctx, labels, data)
//     console.log({elements})
//     compareBtn.addEventListener('click', () => {
//       getLabels(elements);
//       console.log({labels});
//       getData(elements);
//       console.log({data});
//       updateChart(compareChart, labels, data)
//     })
//   }
// }

// export { compareChart };