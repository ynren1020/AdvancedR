map_chr(c(5, 3, 4), int_to_string)

map_lgl(c(1, 2, 3, 4, 5), gt, b=3)

map_if(c(1, 2, 3, 4), is_even, square)

map_at(c(4, 6, 2, 3, 8), c(1,3,4),square)

map2_chr(letters, 1:26, paste)


reduce(c("a", "b", "c", "d"), paste_talk)

reduce_right(c("a", "b", "c", "d"), paste_talk)

has_element(random_ints, 45)

detect(random_ints, is_even)

detect_index(random_ints, is_even)

keep(random_ints, is_even)

discard(random_ints, is_even)

every(random_ints, function(x){x<100})

gt_10 <- partial(gt, b=10)