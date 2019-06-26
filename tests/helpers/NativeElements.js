class NativeElements {
	static toggleButton (element) {
		let startX = element.getLocation().getX();
		let addition = (int) (element.getSize().width * 0.6);
		let endX = startX + addition;
		let startY = element.getLocation().getY();
		new TouchAction(driver).tap(point(endX, startY)).perform();
	}
}

export default NativeElements;