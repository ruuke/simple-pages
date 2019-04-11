page1 = Page.create(
  { name: 'page1', title: 'page1', body: 'page1'}
)

page2 = Page.create(
  { name: 'page2', title: 'page2', body: 'page2', parent_id: page1.id }
)

page3 = Page.create(
  { name: 'page3', title: 'page3', body: 'page3', parent_id: page2.id }
)

page4 = Page.create(
  { name: 'page3', title: 'page3', body: 'page3', parent_id: page3.id }
)
