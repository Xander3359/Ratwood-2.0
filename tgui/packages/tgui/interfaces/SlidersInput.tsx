import { useEffect, useRef, useState } from 'react';
import { NoticeBox, Section, Slider, Stack } from 'tgui-core/components';
import { decodeHtmlEntities } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Loader } from './common/Loader';

type Data = {
  items: ItemData[];
  message: string;
  timeout: number;
  title: string;
}

type ItemData = {
  value: string;
  current_value: number;
  minimum_value: number;
  maximum_value: number;
}

/** Renders a list of sliders, they can be adjusted according to minimum/maximum values for input */
export const SlidersInput = (props) => {
  const { data } = useBackend<Data>();
  const {
    items = [],
    message,
    timeout,
    title,
  } = data;

  const [sliderValues, sliderValueChanged] = useState<number[]>([]);
  const setSliderValues = (newValue: number) => {
    const selectedSliderValue = sliderValues.includes(newValue)
      ? sliderValues.filter((item) => item !== newValue)
      : [...sliderValues, newValue];

    sliderValueChanged(selectedSliderValue);
  };

return (
  <Window title={title}>
    {!!timeout && <Loader value={timeout} />}
      <Window.Content scrollable>
        <Stack fill vertical g={0}>
          <Stack.Item>
            <NoticeBox info textAlign="center">
              {decodeHtmlEntities(message)}{' '}
            </NoticeBox>
          </Stack.Item>
          <Stack.Item>
            {items.map((item) => (
              <Section title={item.value} key={item.value}>
                <Slider
                  value={item.current_value}
                  step={1}
                  stepPixelSize={50}
                  minValue={item.minimum_value}
                  maxValue={item.maximum_value}
                  unit="Points"
                  onChange={() => sliderValueChanged}
                />
              </Section>
            ))}
          </Stack.Item>
        </Stack>
      </Window.Content>
  </Window>
  );
};
