def camel_case(snake_str):
    components = snake_str.split('_')
    return ''.join(x.title() for x in components)


def replace_tabstop(
    snip,
    index,
    default_str,
    replacement='',
    start_offset=0,
    end_offset=0
):
    if len(snip.tabstops) - 1 == index:
        jumped_over = snip.tabstop == 0
    else:
        jumped_over = snip.tabstop == index + 1 and snip.jump_direction == 1
    tabstop = snip.tabstops[index]
    if jumped_over and tabstop.current_text == default_str:
        line = tabstop.start.line
        a = tabstop.start.col + start_offset
        b = tabstop.end.col + end_offset
        content = snip.buffer[line]
        snip.buffer[line] = content[:a] + replacement + content[b:]
