import { COLLECTOR_ENDPOINT, uris, getCount, getValidEvents, resetMicro } from "../helpers/Micro";
import Gestures from "../helpers/Gestures";

describe('The Snowplow Demo app, when first loading,', () => {
    beforeEach(() => {
        resetMicro();
    });

    it('Sends standard events', async () => {
        $('~uriField').setValue(COLLECTOR_ENDPOINT);
        Gestures.swipeLeft(0.1);
        $('~sendEventsButton').click();
        try {
            let count = await getCount();
            expect(count.good).toEqual(15);
            expect(count.bad).toEqual(0);
            expect(count.total).toEqual(15);
        } catch (error) {

        }
    });

    it('Sends screenviews events', async () => {
        Gestures.swipeLeft(1);
        try {
            let count = await getCount();
            expect(count.good).toEqual(1);
            expect(count.bad).toEqual(0);
            expect(count.total).toEqual(1);

            let events = await getValidEvents(uris.SCREEN_VIEW_EVENT);
            expect(events).toEqual(jasmine.any(Array));
            expect(events.length).toEqual(1);
        } catch (error) {

        }
    });
});
