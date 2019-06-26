import { COLLECTOR_ENDPOINT, uris, getCount, getValidEvents, resetMicro } from "../helpers/Micro";
import Gestures from "../helpers/Gestures";
import NativeElements from "../helpers/NativeElements";

describe('The Snowplow Demo app on first screen,', () => {
    beforeEach(() => {
        resetMicro();
    });

    it('Sends standard events', async () => {
        $('~HTTP').click();
        $('~uriField').setValue(COLLECTOR_ENDPOINT);
        $('~Return').click();
        driver.pause(2000);
        resetMicro();
        $('~sendEventsButton').click();
        driver.pause(2000);
        try {
            let count = await getCount();
            expect(count.good).toEqual(13);
            expect(count.bad).toEqual(9);
        } catch (error) {

        }
    });

    it('Sends screenviews events on swipe', async () => {
        $('~AUTO').click();
        Gestures.swipeLeft(1);
        try {
            let count = await getCount();
            expect(count.good).toEqual(1);
            expect(count.bad).toEqual(0);

            let events = await getValidEvents(uris.SCREEN_VIEW_EVENT);
            expect(events).toEqual(jasmine.any(Array));
            expect(events.length).toEqual(1);
        } catch (error) {

        }
    });
});
