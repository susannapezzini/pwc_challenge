import createChart from './create_chart.js'
import updateChart from './update_chart.js'

const compareChart = () => {
  const elements = [...document.getElementsByClassName("select-subproduct")];
	const subs = [...document.getElementsByClassName("sub-count")];
	const sums = [...document.getElementsByClassName("subproduct-price-sum-dd")];
	const compareBtn = document.getElementById("compare-btn");
  console.log({subs});

  const getLabels = (array) => {
    const labels = array.map((e) => {
      const option = e.options.selectedIndex;
      console.log({option});
      console.log({e})
      console.log('e', e.attributes);
      return e.attributes.id.ownerElement[option].dataset.bank;
    });
    return labels;
	};
	const getPrice = (array) => {
		const data = array.map((e) => {
			const option = e.options.selectedIndex;
			return e.attributes.id.ownerElement[option].dataset.subPrice;		
    });
    return data;
	};
	const getCount = (array) => {
		const data = array.map((e) => {
			const option = e.options.selectedIndex;
			return e.attributes.id.ownerElement[option].dataset.tot;		
    });
    return data;
	};
	
  
  const ctx = document.getElementById("compare-subproduct-chart");
	const ctx2 = document.getElementById("demand-deposit-count-chart");
	const ctx3 = document.getElementById("demand-deposit-sum-chart");
	const ctx4 = document.getElementById("subproduct-chart");

  if (!subs) {
    return;
  } else {
    console.log(subs);
  let labels = getLabels(subs);
  console.log({labels})
  let data = getCount(subs);
  createChart(ctx4, labels, data);
  }
	// if (elements) {
	// 	let labels = getLabels(elements);
  //   let data = getPrice(elements);
  //   const compareChart = createChart(ctx, labels, data);
	// 	console.log({ elements });
	// 	compareBtn.addEventListener("click", () => {
	// 		let labels = getLabels(elements);
	// 		console.log({ labels });
	// 		let data = getPrice(elements);
	// 		console.log({ data });
	// 		updateChart(compareChart, labels, data);
	// 	});
	// }


	if (sums) {
		let labels = getLabels(sums);
		console.log({ labels })
		let data = getCount(sums);
		createChart(ctx3, labels, data);
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