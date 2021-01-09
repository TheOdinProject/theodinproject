import { generateLink, encodeContent, decodeContent } from './mdPreviewShare';

describe('encodeContent', () => {
  it('content is correctly encoded to base64', () => {
    const buffer = Buffer.from('This is a test string!', 'utf-8');
    expect(encodeContent('This is a test string!')).toBe(buffer.toString('base64'));
  });
});

describe('decodeContent', () => {
  it('content is correctly decoded from base64', () => {
    const buffer = Buffer.from('This is a test string!', 'utf-8').toString('base64');
    expect(decodeContent(buffer)).toBe('This is a test string!');
  });
});

describe('generateLink', () => {
  const originalWindow = { ...window };
  const windowSpy = jest.spyOn(global, 'window', 'get');
  windowSpy.mockImplementation(() => ({
    ...originalWindow,
    location: {
      ...originalWindow.location,
      host: 'theodinproject.com',
      pathname: '/lessons/preview',
    },
  }));

  it('the correct link is generated', () => {
    const content = encodeContent('This is a test string!');
    expect(generateLink(content)).toBe(`theodinproject.com/lessons/preview?content=${content}`);
  });
});
