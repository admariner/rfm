test_that('output from rfm_plot_bar_chart is as expected', {

  skip_on_cran()

  analysis_date <- as.Date('2006-12-31')
  rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
  p <- rfm_plot_bar_chart(rfm_result)
  vdiffr::expect_doppelganger('rfm barchart', p)

})

test_that('output from rfm_plot_heatmap is as expected', {

  skip_on_cran()

  analysis_date <- as.Date('2006-12-31')
  rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
    revenue, analysis_date)
  p <- rfm_plot_heatmap(rfm_result)
  vdiffr::expect_doppelganger('rfm heatmap', p)

})

test_that('output from rfm_plot_histograms is as expected', {

  skip_on_cran()

  analysis_date <- as.Date('2006-12-31')
  rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
    revenue, analysis_date)
  p <- rfm_plot_histogram(rfm_result)
  vdiffr::expect_doppelganger('rfm histograms', p)

})

test_that('output from rfm_plot_order_dist is as expected', {

  skip_on_cran()

  analysis_date <- as.Date('2006-12-31')
  rfm_result <- rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
    revenue, analysis_date)
  
  p <- rfm_plot_order_dist(rfm_result)
  vdiffr::expect_doppelganger('rfm orderdist', p)

  p1 <- rfm_plot_order_dist(rfm_result, flip = TRUE)
  vdiffr::expect_doppelganger('rfm orderdist flip', p1)

})

analysis_date <- as.Date('2006-12-31')
rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
revenue, analysis_date)

segment_names <- c("Champions", "Loyal Customers", "Potential Loyalist",
  "New Customers", "Promising", "Need Attention", "About To Sleep",
  "At Risk", "Can't Lose Them", "Lost")

recency_lower <- c(4, 2, 3, 4, 3, 2, 2, 1, 1, 1)
recency_upper <- c(5, 5, 5, 5, 4, 3, 3, 2, 1, 2)
frequency_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
frequency_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
monetary_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
monetary_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)

segments <- rfm_segment(rfm_result, segment_names, recency_lower,
recency_upper, frequency_lower, frequency_upper, monetary_lower,
monetary_upper)

my_segments <- rfm_segment_summary(segments)

test_that('output from rfm_plot_median_recency is as expected', {

  skip_on_cran()
  vdiffr::expect_doppelganger('rfm median recency', rfm_plot_median_recency(segments))
  vdiffr::expect_doppelganger('rfm median recency sort ascending', rfm_plot_median_recency(segments, sort = TRUE, ascending = TRUE))
  vdiffr::expect_doppelganger('rfm median recency sort', rfm_plot_median_recency(segments, sort = TRUE))
  vdiffr::expect_doppelganger('rfm median recency flip', rfm_plot_median_recency(segments, flip = TRUE))
  vdiffr::expect_doppelganger('rfm median recency sort ascending flip', rfm_plot_median_recency(segments, sort = TRUE, ascending = TRUE, flip = TRUE))
  vdiffr::expect_doppelganger('rfm median recency sort flip', rfm_plot_median_recency(segments, sort = TRUE, flip = TRUE))

})

test_that('output from rfm_plot_median_frequency is as expected', {

  skip_on_cran()

  vdiffr::expect_doppelganger('rfm median frequency', rfm_plot_median_frequency(segments))
  vdiffr::expect_doppelganger('rfm median frequency sort ascending', rfm_plot_median_frequency(segments, sort = TRUE, ascending = TRUE))
  vdiffr::expect_doppelganger('rfm median frequency sort', rfm_plot_median_frequency(segments, sort = TRUE))
  vdiffr::expect_doppelganger('rfm median frequency flip', rfm_plot_median_frequency(segments, flip = TRUE))
  vdiffr::expect_doppelganger('rfm median frequency sort ascending flip', rfm_plot_median_frequency(segments, sort = TRUE, ascending = TRUE, flip = TRUE))
  vdiffr::expect_doppelganger('rfm median frequency sort flip', rfm_plot_median_frequency(segments, sort = TRUE, flip = TRUE))

})

test_that('output from rfm_plot_median_monetary is as expected', {

  skip_on_cran()

  vdiffr::expect_doppelganger('rfm median monetary', rfm_plot_median_monetary(segments))
  vdiffr::expect_doppelganger('rfm median monetary sort ascending', rfm_plot_median_monetary(segments, sort = TRUE, ascending = TRUE))
  vdiffr::expect_doppelganger('rfm median monetary sort', rfm_plot_median_monetary(segments, sort = TRUE))
  vdiffr::expect_doppelganger('rfm median monetary flip', rfm_plot_median_monetary(segments, flip = TRUE))
  vdiffr::expect_doppelganger('rfm median monetary sort ascending flip', rfm_plot_median_monetary(segments, sort = TRUE, ascending = TRUE, flip = TRUE))
  vdiffr::expect_doppelganger('rfm median monetary sort flip', rfm_plot_median_monetary(segments, sort = TRUE, flip = TRUE))

})

test_that("output from rfm_plot_segment_summary is as expected", {
  skip_on_cran()

  p <- rfm_plot_segment_summary(my_segments, print_plot = FALSE)
  vdiffr::expect_doppelganger("customers by segment", p)

})

test_that("output from rfm_plot_segment_summary is as expected when metrics are selected", {
  skip_on_cran()

  p <- rfm_plot_segment_summary(my_segments, metric = "orders", print_plot = FALSE)
  vdiffr::expect_doppelganger("orders by segment", p)
  
})

test_that("output from rfm_plot_segment_summary is as expected when sorted", {
  skip_on_cran()
  
  p <- rfm_plot_segment_summary(my_segments, metric = "orders", sort = TRUE, 
                                ascending = TRUE, print_plot = FALSE)
  vdiffr::expect_doppelganger("orders by segment sorted", p)
})

test_that("output from rfm_plot_segment_summary is as expected when sorted in descending order", {
  skip_on_cran()
  
   p <- rfm_plot_segment_summary(my_segments, metric = "revenue", sort = TRUE, 
                                 print_plot = FALSE)
   vdiffr::expect_doppelganger("revenue by segment descending new", p)

})

test_that("output from rfm_plot_segment_summary is as expected when flipped", {
  skip_on_cran()

  p <- rfm_plot_segment_summary(my_segments, metric = "orders", flip = TRUE, 
                                print_plot = FALSE)
  vdiffr::expect_doppelganger("orders by segment flipped", p)
  
})

test_that("output from rfm_plot_segment_summary is as expected when flipped & sorted", {
  skip_on_cran()

  p <- rfm_plot_segment_summary(my_segments, metric = "orders", sort = TRUE, 
                                flip = TRUE, print_plot = FALSE)
  vdiffr::expect_doppelganger("orders by segment flipped sorted", p)
  
})

test_that("output from rfm_plot_segment_summary is as expected when flipped & sorted in ascending order", {
  skip_on_cran()

  p <- rfm_plot_segment_summary(my_segments, metric = "orders", sort = TRUE, 
                                ascending = TRUE, flip = TRUE, print_plot = FALSE)
   vdiffr::expect_doppelganger("orders by segment descending", p)
  
})

test_that('output from rfm_plot_revenue_dist is as expected', {

  skip_on_cran()

  p <- rfm_plot_revenue_dist(my_segments)
  vdiffr::expect_doppelganger('rfm plot revenue dist', p)

  p1 <- rfm_plot_revenue_dist(my_segments, flip = TRUE)
  vdiffr::expect_doppelganger('rfm plot revenue dist flipped', p1)

})

test_that('output from rfm_plot_segment is as expected', {

  skip_on_cran()

  p <- rfm_plot_segment(my_segments)
  vdiffr::expect_doppelganger('rfm plot segment', p)
})

test_that('output from rfm_plot_segment_scatter is as expected', {

  skip_on_cran()

  p <- rfm_plot_segment_scatter(segments, "monetary", "recency")
  vdiffr::expect_doppelganger('rfm plot segment scatter', p)
})

