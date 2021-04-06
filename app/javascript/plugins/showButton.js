const showButton = () => {
  window.addEventListener('scroll', event => {
    const bottomNav = document.querySelector('.bottom_nav');
    if (!bottomNav) {
      return;
    }
    // console.log(bottomNav);
    bottomNav.classList.add('show');
    // console.log(event);
    // console.log(event.srcElement.scrollingElement.scrollTop);
    const height = event.srcElement.scrollingElement.scrollTop;
    const footer = document.querySelector('footer');
    console.log(footer);
    console.log(bottomNav);
    const diff = (height - footer.offsetHeight);
    console.log({height});
    if (height < 150) {
      bottomNav.classList.remove('show');
      // console.log(up);
    } 
    // else if (diff) {
    //   up.classList.remove('show');
    //   up.classList.add('stay_there');
    //   console.log(up);
    // }
  });
}

export { showButton };